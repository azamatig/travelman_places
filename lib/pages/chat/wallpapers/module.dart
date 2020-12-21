import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';

class WallpaperModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => WallpapersRepoImp()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(
          WALLPAPERS,
          child: (_, args) => WallpapersScreen(),
        ),
        m.ModularRouter(
          ADD,
          child: (_, args) => AddWallpaperScreen(),
        ),
      ];
  static const WALLPAPERS = '/wallpapers', ADD = '/add_wallpaper';

  static Future toWallpapers() => m.Modular.to.pushNamed(WALLPAPERS);
  static Future toAddWall() => m.Modular.to.pushNamed(ADD);
  static Future toWallpaper(int index) => _to(WallpaperPage(index));

  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
