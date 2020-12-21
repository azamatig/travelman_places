// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WallpaperModel _$_$_WallpaperModelFromJson(Map<String, dynamic> json) {
  return _$_WallpaperModel(
    id: json['id'] as String,
    fileName: json['fileName'] as String,
    url: json['url'] as String,
    uploaderId: json['uploaderId'] as String,
    uploaderName: json['uploaderName'] as String,
    downloadsCount: json['downloadsCount'] as int,
    commentsCount: json['commentsCount'] as int,
    likesId: (json['likesId'] as List)?.map((e) => e as String)?.toList(),
    commentsId: (json['commentsId'] as List)?.map((e) => e as String)?.toList(),
    downloads: (json['downloads'] as List)?.map((e) => e as String)?.toList(),
    uploadDate: _timeFromJson(json['uploadDate']),
  );
}

Map<String, dynamic> _$_$_WallpaperModelToJson(_$_WallpaperModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'url': instance.url,
      'uploaderId': instance.uploaderId,
      'uploaderName': instance.uploaderName,
      'downloadsCount': instance.downloadsCount,
      'commentsCount': instance.commentsCount,
      'likesId': instance.likesId,
      'commentsId': instance.commentsId,
      'downloads': instance.downloads,
      'uploadDate': _timeToJson(instance.uploadDate),
    };
