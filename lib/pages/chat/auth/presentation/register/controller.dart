import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../export.dart';

part 'controller.g.dart';

class RegisterController = _RegisterController
    with _$RegisterController
    implements Disposable;

abstract class _RegisterController with Store {
  final userRepo = Modular.get<UserRepository>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final statusController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @observable
  File photoFile;

  @observable
  String gender = 'Male';

  @observable
  bool isRegistering = false;

  @observable
  bool hasAcceptedTermAndConditions = false;

  @action
  Future<void> registerUser() async {
    if (!formKey.currentState.validate() || !hasAcceptedTermAndConditions) {
      return;
    }
    isRegistering = true;
    final username = usernameController.text.toLowerCase().trim();
    if (username.isEmpty || await userRepo.checkIfUsernameTaken(username)) {
      BotToast.showText(text: t.Auth.name_taken);
      return;
    }
    final photoUrl = photoFile == null
        ? null
        : await uploadFile(photoFile, Constants.PROFILE_PHOTO_CHILD_NAME);
    final user = await userRepo.registerUser(
      username: username,
      email: emailController.text,
      gender: gender,
      photoUrl: photoUrl,
      status: statusController.text,
    );
    if (user == null) {
      BotToast.showText(text: t.Auth.login_first);
      return;
    }
    await Modular.get<AuthController>().addEvent(AuthEvent.loggedIn(user.id));
    Modular.to.popUntil((r) => r.isFirst);

    isRegistering = false;
  }

  @action
  Future<void> pickPhoto() async {
    final picked = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 90);
    photoFile = picked == null ? null : File(picked.path);
  }

  void dispose() {
    usernameController.dispose();
    statusController.dispose();
    emailController.dispose();
  }
}
