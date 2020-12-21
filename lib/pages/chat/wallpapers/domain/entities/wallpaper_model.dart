import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../export.dart';

part 'wallpaper_model.freezed.dart';
part 'wallpaper_model.g.dart';

@freezed
abstract class WallpaperModel with _$WallpaperModel {
  const factory WallpaperModel({
    String id,
    String fileName,
    String url,
    String uploaderId,
    String uploaderName,
    int downloadsCount,
    int commentsCount,
    List<String> likesId,
    List<String> commentsId,
    List<String> downloads,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime uploadDate,
  }) = _WallpaperModel;

  static WallpaperModel newInstance({
    @required String fileName,
    @required String url,
    @required User currentUser,
  }) {
    return WallpaperModel(
      id: '${DateTime.now().millisecondsSinceEpoch}-$fileName',
      fileName: fileName,
      url: url,
      uploaderId: currentUser.id,
      uploaderName: currentUser.name,
      likesId: [],
      commentsId: [],
      downloads: [],
      commentsCount: 0,
      downloadsCount: 0,
      uploadDate: DateTime.now().toUtc(),
    );
  }

  factory WallpaperModel.fromJson(Map<String, dynamic> json) =>
      _$WallpaperModelFromJson(json);
}

DateTime _timeFromJson(ts) => ts == null
    ? DateTime.now()
    : ts is DateTime ? ts : (ts as Timestamp)?.toDate();
DateTime _timeToJson(DateTime time) => time;
