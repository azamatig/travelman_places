import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

import '../../export.dart';
import '../wallpapers/controller.dart';

part 'controller.g.dart';

class WallpaperPageController = _WallpaperPageController
    with _$WallpaperPageController;

abstract class _WallpaperPageController with Store {
  @observable
  int wallIndex;
  _WallpaperPageController(this.wallIndex) {
    doesLikeIt = currentWallpaper.likesId.contains(currentUser.id);
  }

  final repo = Modular.get<WallpaperRepository>();
  final wallController = Modular.get<WallpapersController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User get currentUser => Modular.get<AuthController>().currentUser;

  @computed
  List<WallpaperModel> get walls => wallController.wallpapers;

  @computed
  WallpaperModel get currentWallpaper => walls[wallIndex];

  @observable
  bool doesLikeIt;

  @computed
  int get wallsOffset => wallController.wallsOffset;

  @action
  Future<void> addOrRemoveReaction() async {
    if (doesLikeIt) {
      doesLikeIt = false;
      currentWallpaper.likesId.remove(currentUser.id);
      await repo.removeWallpaperReaction(currentUser.id, currentWallpaper);
    } else {
      doesLikeIt = true;
      currentWallpaper.likesId.add(currentUser.id);
      await repo.addWallpaperReaction(currentUser.id, currentWallpaper);
    }
  }

  @action
  Future<void> downloadWall() async {
    try {
      await showDownloadProgressBar(currentWallpaper.url,
          fileName: currentWallpaper.fileName);
      await repo.wallpaperDownloaded(currentUser.id, currentWallpaper);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void setWallpaper(WallpaperLocation location) async {
    BotToast.showLoading();
    Modular.to.pop();
    try {
      final file =
          await DefaultCacheManager().getSingleFile(currentWallpaper.url);
      String result;
      switch (location) {
        case WallpaperLocation.HOME:
          result = await WallpaperManager.setWallpaperFromFile(
              file.path, WallpaperManager.HOME_SCREEN);
          break;
        case WallpaperLocation.LOCK:
          result = await WallpaperManager.setWallpaperFromFile(
              file.path, WallpaperManager.LOCK_SCREEN);
          break;
        default:
          await WallpaperManager.setWallpaperFromFile(
              file.path, WallpaperManager.HOME_SCREEN);
          result = await WallpaperManager.setWallpaperFromFile(
              file.path, WallpaperManager.LOCK_SCREEN);
      }

      BotToast.showText(text: result);
    } catch (e) {
      print(e);
    }
    BotToast.closeAllLoading();
  }
}

enum WallpaperLocation { HOME, LOCK, BOTH }
