import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travelman/pages/chat/wallpapers/module.dart';

import '../../export.dart';
import '../widgets/img_card.dart';
import 'controller.dart';
import 'widgets/sorter.dart';

class WallpapersScreen extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((_) => WallpapersController())];

  @override
  Widget get view => _WallpapersScreen();
}

class _WallpapersScreen extends StatefulWidget {
  @override
  _WallpapersScreenState createState() => _WallpapersScreenState();
}

class _WallpapersScreenState
    extends ModularState<_WallpapersScreen, WallpapersController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Observer(
        builder: (_) => StreamBuilder<List<WallpaperModel>>(
            stream: controller.wallpapersStream,
            builder: (context, snapshot) {
              controller.wallpapers = (snapshot.data ?? []).asObservable();
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: false,
                enablePullUp:
                    controller.wallsOffset <= controller.wallpapers.length,
                onLoading: controller.onRefreshLoading,
                child: CustomScrollView(
                  controller: controller.scrolleController,
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: true,
                      elevation: 5,
                      pinned: true,
                      floating: true,
                      title: Text(
                        t.Drawer.wallpapers,
                        style: theme.textTheme.headline5,
                      ),
                      backgroundColor: theme.primaryColor,
                      bottom: CategoriesSortWidget(
                        query: controller.query,
                        onChange: (v) {
                          controller.query = v;
                          controller.scrolleController.jumpTo(0);
                        },
                      ),
                    ),
                    SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 4,
                      itemCount: controller.wallpapers.length,
                      itemBuilder: (_, i) => ImageCard(
                        url: controller.wallpapers[i].url,
                        onTap: () => WallpaperModule.toWallpaper(i),
                      ),
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(2, index.isEven ? 4 : 3),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: Observer(
        builder: (_) => !controller.showAddIcon
            ? SizedBox.shrink()
            : MaterialButton(
                color: theme.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(width: 6),
                    Text(t.Wallpapers.add_wallpaper),
                  ],
                ),
                onPressed: WallpaperModule.toAddWall,
              ),
      ),
    );
  }
}
