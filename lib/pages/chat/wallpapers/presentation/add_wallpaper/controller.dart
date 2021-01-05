import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import '../../export.dart';

part 'controller.g.dart';

class AddWallController = _AddWallController
    with _$AddWallController
    implements Disposable;

abstract class _AddWallController with Store {
  final repo = Modular.get<WallpaperRepository>();
  final nameController = TextEditingController();

  User get currentUser => Modular.get<AuthController>().currentUser;

  @observable
  var uploadImgListener = UploadState.initial();

  void pickWallpaper() async {
    final picked = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 90);
    if (picked == null) {
      BotToast.showText(text: t.Wallpapers.no_img_selected);
      return;
    } else {
      uploadImgListener = UploadState.wallpaperPicked(picked.path);
    }
  }

  void uploadWallpaper() async {
    final name = nameController.text;
    await uploadImgListener.maybeWhen(
        wallpaperPicked: (path) async {
          try {
            String url;
            uploadImgListener = UploadState.uploading();
            url = await uploadFile(File(path), 'Wallpapers/', fileName: name);
            if (url != null) {
              uploadImgListener = UploadState.success(url);
              final wall = WallpaperModel.newInstance(
                fileName: name,
                url: url,
                currentUser: currentUser,
              );
              await repo.uploadWallpaper(wall);
              BotToast.showText(text: t.Wallpapers.upload_finished);
              uploadImgListener = UploadState.initial();
            } else {
              uploadImgListener = UploadState.failed();
            }
          } catch (e, s) {
            Logger().e('Error Upload Wallpaper', e);
            uploadImgListener = UploadState.failed();
            print(s);
          }
        },
        orElse: () {});
  }

  void dispose() {
    nameController.dispose();
  }
}
