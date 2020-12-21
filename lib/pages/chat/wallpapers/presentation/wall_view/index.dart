import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../export.dart';
import 'controller.dart';

class WallpaperPage extends WidgetModule {
  final int wallIndex;
  WallpaperPage(this.wallIndex);

  @override
  List<Bind> get binds => [Bind((_) => WallpaperPageController(wallIndex))];

  @override
  Widget get view => _WallpaperPage();
}

class _WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState
    extends ModularState<_WallpaperPage, WallpaperPageController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: controller.scaffoldKey,
      body: Stack(
        children: <Widget>[
          Hero(
            tag: controller.currentWallpaper.url,
            child: Observer(
              builder: (_) {
                final walls = controller.walls;
                if (walls.isEmpty) return Container();
                return PageView.builder(
                  itemCount: walls.length,
                  controller:
                      PageController(initialPage: controller.wallIndex ?? 0),
                  onPageChanged: (i) async {
                    controller.wallIndex = i;
                    if (controller.wallsOffset <= walls.length &&
                        i == walls.length - 1) {
                      controller.wallController.onRefreshLoading();
                    }
                  },
                  itemBuilder: (_, i) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomNetworkImage(
                      url: walls[i].url,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 28,
            left: 8,
            child: FloatingActionButton(
              tooltip: 'Close',
              child: Icon(
                Icons.clear,
                color: theme.accentColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: 'close',
              mini: true,
              backgroundColor: theme.primaryColor.withOpacity(0.5),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 150,
                ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.height - 200,
                      decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, left: 16.0),
                              child: Text(
                                controller.currentWallpaper.fileName,
                                style: theme.textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Observer(
                            builder: (_) => Row(
                              children: <Widget>[
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    controller.doesLikeIt
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: controller.addOrRemoveReaction,
                                ),
                                Container(
                                    width: 0.5,
                                    height: 20,
                                    color: theme.iconTheme.color),
                                SizedBox(width: 10),
                                GestureDetector(
                                  child: Text(
                                    '${controller.currentWallpaper.likesId?.length ?? 0} ${t.Feed.likes}',
                                    style: theme.textTheme.subtitle1,
                                  ),
                                  onTap: () {
                                    FeedsModule.toReactions(
                                        controller.currentWallpaper.likesId);
                                  },
                                ),
                                SizedBox(width: 30),
                                FlatButton.icon(
                                  icon: Icon(Icons.file_download),
                                  label: Text(
                                    '${controller.currentWallpaper.downloadsCount ?? 0}',
                                    style: theme.textTheme.subtitle1,
                                  ),
                                  onPressed: controller.downloadWall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!kIsWeb && Platform.isAndroid)
                    Positioned(
                      right: 16.0,
                      top: 0.0,
                      child: FloatingActionButton(
                        tooltip: t.Wallpapers.set_as_wallpaper,
                        backgroundColor: theme.primaryColor,
                        child: Icon(
                          Icons.format_paint,
                          color: theme.accentColor,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () => controller.setWallpaper(
                                        WallpaperLocation.BOTH,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.add_to_home_screen),
                                          Text(t.Wallpapers.both),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.setWallpaper(
                                        WallpaperLocation.LOCK,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.lock),
                                          Text(t.Wallpapers.lock),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.setWallpaper(
                                        WallpaperLocation.HOME,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.home),
                                          Text(t.Wallpapers.home),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
