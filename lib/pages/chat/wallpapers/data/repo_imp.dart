import 'package:cloud_firestore/cloud_firestore.dart';

import '../export.dart';

class WallpapersRepoImp extends WallpaperRepository {
  static final _firestore = FirebaseFirestore.instance;

  CollectionReference get _wallpapersCollection =>
      _firestore.collection('Wallpapers');
  DocumentReference _wallDoc(String id) => _wallpapersCollection.doc(id);

  @override
  Stream<List<WallpaperModel>> wallpapersStream(
      WallpapersQuery query, int offset, String userId) {
    var col = _wallpapersCollection.limit(offset);

    query.when(
      newest: () {
        col = col.orderBy(query.filterField, descending: true);
      },
      trending: () {
        col = col.orderBy(query.filterField, descending: true);
      },
      mostDownloaded: () {
        col = col.orderBy(query.filterField, descending: true);
      },
      myFavorites: () {
        col = col
            .where(query.filterField, arrayContains: userId)
            .orderBy(WallpapersQuery.Newest.filterField, descending: true);
      },
    );

    return col.snapshots().map(
        (s) => [for (final w in s.docs) WallpaperModel.fromJson(w.data())]);
  }

  @override
  Future<void> addWallpaperReaction(String userId, WallpaperModel wallpaper) =>
      _wallDoc(wallpaper.id).update({
        'likesId': FieldValue.arrayUnion([userId]),
        'likesCount': FieldValue.increment(1)
      });

  @override
  Future<void> removeWallpaperReaction(
          String userId, WallpaperModel wallpaper) =>
      _wallDoc(wallpaper.id).update({
        'likesId': FieldValue.arrayRemove([userId]),
        'likesCount': FieldValue.increment(-1)
      });

  @override
  Future<void> wallpaperDownloaded(String userId, WallpaperModel wallpaper) =>
      _wallDoc(wallpaper.id).update({
        'downloads': FieldValue.arrayUnion([userId]),
        'downloadsCount': FieldValue.increment(1),
      });

  @override
  Future<void> uploadWallpaper(WallpaperModel wallpaper) =>
      _wallDoc(wallpaper.id).set(wallpaper.toJson());
}
