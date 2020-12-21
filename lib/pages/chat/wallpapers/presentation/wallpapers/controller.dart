import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../export.dart';

part 'controller.g.dart';

class WallpapersController = _WallpapersController
    with _$WallpapersController
    implements Disposable;

abstract class _WallpapersController with Store {
  _WallpapersController() {
    scrolleController.addListener(scrollListener);
  }
  final repo = Modular.get<WallpaperRepository>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshController = RefreshController(initialRefresh: false);
  final scrolleController = ScrollController();

  User get currentUser => Modular.get<AuthController>().currentUser;

  @observable
  bool showAddIcon = true;

  @action
  void scrollListener() {
    if (scrolleController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        showAddIcon) {
      showAddIcon = false;
    } else if (scrolleController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !showAddIcon) {
      showAddIcon = true;
    }
  }

  var wallpapers = <WallpaperModel>[].asObservable();

  var pageIndex = 0;

  Stream<List<WallpaperModel>> get wallpapersStream =>
      repo.wallpapersStream(query, wallsOffset, currentUser.id);

  @action
  void onRefreshLoading() {
    wallsOffset = wallpapers.length + 10;
    refreshController.loadComplete();
  }

  @observable
  WallpapersQuery query = WallpapersQuery.Newest;

  @observable
  int wallsOffset = 20;

  void dispose() {
    scrolleController.removeListener(scrollListener);
    scrolleController.dispose();
    refreshController.dispose();
  }
}
