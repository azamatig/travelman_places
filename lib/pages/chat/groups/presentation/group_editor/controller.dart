import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../export.dart';

part 'controller.g.dart';

class GroupEditorController = _GroupEditorController
    with _$GroupEditorController
    implements Disposable;

abstract class _GroupEditorController with Store {
  final repo = Modular.get<GroupsRepository>();

  final Group toEditGroup;
  _GroupEditorController(this.toEditGroup) {
    nameController.text = toEditGroup?.name ?? '';
    photoUrl = toEditGroup?.photoUrl;
  }
  User get currentUser => Modular.get<AuthController>().currentUser;
  final nameController = TextEditingController();

  bool get isToEdit => toEditGroup != null;

  @observable
  String photoUrl;

  @observable
  File imageFileToUpload;

  @observable
  bool isImageUploading = false;

  Future<void> onPressed() async {
    final name = nameController.text;
    if (name.isEmpty) {
      BotToast.showText(text: 'Please! Add Group Name');
      return;
    }
    try {
      await createOrEditGroup(name);
      Modular.to.pop();
    } catch (e) {
      BotToast.showText(
          text: 'Oops! Something went wrong while uploading image');
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 90);
    imageFileToUpload = picked == null ? null : File(picked.path);
  }

  @action
  Future<void> createOrEditGroup(String name) async {
    isImageUploading = true;
    var imgUrl = '';
    if (imageFileToUpload?.existsSync() == true) {
      imgUrl = await uploadFile(imageFileToUpload, 'Groups/$name/',
              fileName: 'Logo') ??
          '';
    }
    if (isToEdit) {
      toEditGroup
        ..name = name
        ..photoUrl = imgUrl.isEmpty ? toEditGroup.photoUrl : imgUrl;
      await repo.editGroup(
          id: toEditGroup.id, name: name, photoUrl: toEditGroup.photoUrl);
    } else {
      final group =
          Group.create(name: name, userId: currentUser.id, imgUrl: imgUrl);
      await repo.createGroup(group);
    }
    isImageUploading = false;
    imageFileToUpload = null;
  }

  void dispose() {
    nameController.dispose();
  }
}
