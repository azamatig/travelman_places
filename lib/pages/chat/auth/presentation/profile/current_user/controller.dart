import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import '../../../export.dart';

part 'controller.g.dart';

class UserController = _UserControllerBase
    with _$UserController
    implements Disposable;

abstract class _UserControllerBase with Store {
  final authRepo = Modular.get<AuthRepository>();
  final userRepo = Modular.get<UserRepository>();

  final nameController = TextEditingController();
  final statusController = TextEditingController();

  User get currentUser => Modular.get<AuthController>().currentUser;

  void updateUserInfo() async {
    final name = nameController.text.trim().toLowerCase();
    final status = statusController.text;
    if (name == currentUser.name && status == currentUser.status) {
      return;
    }
    if (await userRepo.checkIfUsernameTaken(name)) {
      BotToast.showText(text: t.Auth.name_taken);
      return;
    }
    try {
      currentUser
        ..name = name
        ..status = status;
      await userRepo.updateUseInfo(currentUser);
    } catch (e, s) {}
  }

  void changeProfilePic() async {
    final img = await ImagePicker().getImage(source: ImageSource.gallery);
    if (img != null) {
      String url;
      try {
        url = await uploadFile(
            File(img.path), Constants.PROFILE_PHOTO_CHILD_NAME);
        Logger().i('Image Upload URL', url);
      } catch (e, s) {
        Logger().e('Change Profiel Pic', e);
      }
      if (url != null) {
        currentUser.photoUrl = url;
        await userRepo.updateUseInfo(currentUser);
      }
    }
  }

  void dispose() {
    nameController.dispose();
    statusController.dispose();
  }

  Future<User> fetcheUser(String uid) => userRepo.fetchUserData(uid);
}
