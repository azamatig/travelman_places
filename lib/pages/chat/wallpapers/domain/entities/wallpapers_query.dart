import 'package:meta/meta.dart';

import '../../export.dart';

enum WallpapersQuery {
  Newest,
  Trending,
  MostDownloaded,
  MyFavorites,
}

extension WallpapesQueryExt on WallpapersQuery {
  String get text {
    return when<String>(
      newest: () => t.Wallpapers.newest,
      trending: () => t.Wallpapers.trending,
      mostDownloaded: () => t.Wallpapers.downloaded,
      myFavorites: () => t.Wallpapers.favorite,
    );
  }

  String get filterField {
    return when<String>(
      newest: () => 'uploadDate',
      trending: () => 'likesCount',
      mostDownloaded: () => 'downloadsCount',
      myFavorites: () => 'likesId',
    );
  }

  R when<R>({
    @required R Function() newest,
    @required R Function() trending,
    @required R Function() mostDownloaded,
    @required R Function() myFavorites,
  }) {
    switch (this) {
      case WallpapersQuery.Newest:
        return newest();
      case WallpapersQuery.Trending:
        return trending();
      case WallpapersQuery.MostDownloaded:
        return mostDownloaded();
      case WallpapersQuery.MyFavorites:
        return myFavorites();
      default:
        return null;
    }
  }
}
