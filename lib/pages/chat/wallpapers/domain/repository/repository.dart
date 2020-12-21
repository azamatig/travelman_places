import '../../export.dart';

abstract class WallpaperRepository {
  Stream<List<WallpaperModel>> wallpapersStream(
      WallpapersQuery query, int offset, String userId);
  Future<void> addWallpaperReaction(String userId, WallpaperModel wallpaper);
  Future<void> removeWallpaperReaction(String userId, WallpaperModel wallpaper);
  Future<void> wallpaperDownloaded(String userId, WallpaperModel wallpaper);
  Future<void> uploadWallpaper(WallpaperModel wallpaper);
}
