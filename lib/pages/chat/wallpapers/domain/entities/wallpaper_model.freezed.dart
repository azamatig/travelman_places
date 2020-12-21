// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'wallpaper_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
WallpaperModel _$WallpaperModelFromJson(Map<String, dynamic> json) {
  return _WallpaperModel.fromJson(json);
}

class _$WallpaperModelTearOff {
  const _$WallpaperModelTearOff();

// ignore: unused_element
  _WallpaperModel call(
      {String id,
      String fileName,
      String url,
      String uploaderId,
      String uploaderName,
      int downloadsCount,
      int commentsCount,
      List<String> likesId,
      List<String> commentsId,
      List<String> downloads,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime uploadDate}) {
    return _WallpaperModel(
      id: id,
      fileName: fileName,
      url: url,
      uploaderId: uploaderId,
      uploaderName: uploaderName,
      downloadsCount: downloadsCount,
      commentsCount: commentsCount,
      likesId: likesId,
      commentsId: commentsId,
      downloads: downloads,
      uploadDate: uploadDate,
    );
  }
}

// ignore: unused_element
const $WallpaperModel = _$WallpaperModelTearOff();

mixin _$WallpaperModel {
  String get id;
  String get fileName;
  String get url;
  String get uploaderId;
  String get uploaderName;
  int get downloadsCount;
  int get commentsCount;
  List<String> get likesId;
  List<String> get commentsId;
  List<String> get downloads;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get uploadDate;

  Map<String, dynamic> toJson();
  $WallpaperModelCopyWith<WallpaperModel> get copyWith;
}

abstract class $WallpaperModelCopyWith<$Res> {
  factory $WallpaperModelCopyWith(
          WallpaperModel value, $Res Function(WallpaperModel) then) =
      _$WallpaperModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String fileName,
      String url,
      String uploaderId,
      String uploaderName,
      int downloadsCount,
      int commentsCount,
      List<String> likesId,
      List<String> commentsId,
      List<String> downloads,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime uploadDate});
}

class _$WallpaperModelCopyWithImpl<$Res>
    implements $WallpaperModelCopyWith<$Res> {
  _$WallpaperModelCopyWithImpl(this._value, this._then);

  final WallpaperModel _value;
  // ignore: unused_field
  final $Res Function(WallpaperModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object fileName = freezed,
    Object url = freezed,
    Object uploaderId = freezed,
    Object uploaderName = freezed,
    Object downloadsCount = freezed,
    Object commentsCount = freezed,
    Object likesId = freezed,
    Object commentsId = freezed,
    Object downloads = freezed,
    Object uploadDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      fileName: fileName == freezed ? _value.fileName : fileName as String,
      url: url == freezed ? _value.url : url as String,
      uploaderId:
          uploaderId == freezed ? _value.uploaderId : uploaderId as String,
      uploaderName: uploaderName == freezed
          ? _value.uploaderName
          : uploaderName as String,
      downloadsCount: downloadsCount == freezed
          ? _value.downloadsCount
          : downloadsCount as int,
      commentsCount: commentsCount == freezed
          ? _value.commentsCount
          : commentsCount as int,
      likesId: likesId == freezed ? _value.likesId : likesId as List<String>,
      commentsId: commentsId == freezed
          ? _value.commentsId
          : commentsId as List<String>,
      downloads:
          downloads == freezed ? _value.downloads : downloads as List<String>,
      uploadDate:
          uploadDate == freezed ? _value.uploadDate : uploadDate as DateTime,
    ));
  }
}

abstract class _$WallpaperModelCopyWith<$Res>
    implements $WallpaperModelCopyWith<$Res> {
  factory _$WallpaperModelCopyWith(
          _WallpaperModel value, $Res Function(_WallpaperModel) then) =
      __$WallpaperModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String fileName,
      String url,
      String uploaderId,
      String uploaderName,
      int downloadsCount,
      int commentsCount,
      List<String> likesId,
      List<String> commentsId,
      List<String> downloads,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime uploadDate});
}

class __$WallpaperModelCopyWithImpl<$Res>
    extends _$WallpaperModelCopyWithImpl<$Res>
    implements _$WallpaperModelCopyWith<$Res> {
  __$WallpaperModelCopyWithImpl(
      _WallpaperModel _value, $Res Function(_WallpaperModel) _then)
      : super(_value, (v) => _then(v as _WallpaperModel));

  @override
  _WallpaperModel get _value => super._value as _WallpaperModel;

  @override
  $Res call({
    Object id = freezed,
    Object fileName = freezed,
    Object url = freezed,
    Object uploaderId = freezed,
    Object uploaderName = freezed,
    Object downloadsCount = freezed,
    Object commentsCount = freezed,
    Object likesId = freezed,
    Object commentsId = freezed,
    Object downloads = freezed,
    Object uploadDate = freezed,
  }) {
    return _then(_WallpaperModel(
      id: id == freezed ? _value.id : id as String,
      fileName: fileName == freezed ? _value.fileName : fileName as String,
      url: url == freezed ? _value.url : url as String,
      uploaderId:
          uploaderId == freezed ? _value.uploaderId : uploaderId as String,
      uploaderName: uploaderName == freezed
          ? _value.uploaderName
          : uploaderName as String,
      downloadsCount: downloadsCount == freezed
          ? _value.downloadsCount
          : downloadsCount as int,
      commentsCount: commentsCount == freezed
          ? _value.commentsCount
          : commentsCount as int,
      likesId: likesId == freezed ? _value.likesId : likesId as List<String>,
      commentsId: commentsId == freezed
          ? _value.commentsId
          : commentsId as List<String>,
      downloads:
          downloads == freezed ? _value.downloads : downloads as List<String>,
      uploadDate:
          uploadDate == freezed ? _value.uploadDate : uploadDate as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_WallpaperModel
    with DiagnosticableTreeMixin
    implements _WallpaperModel {
  const _$_WallpaperModel(
      {this.id,
      this.fileName,
      this.url,
      this.uploaderId,
      this.uploaderName,
      this.downloadsCount,
      this.commentsCount,
      this.likesId,
      this.commentsId,
      this.downloads,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.uploadDate});

  factory _$_WallpaperModel.fromJson(Map<String, dynamic> json) =>
      _$_$_WallpaperModelFromJson(json);

  @override
  final String id;
  @override
  final String fileName;
  @override
  final String url;
  @override
  final String uploaderId;
  @override
  final String uploaderName;
  @override
  final int downloadsCount;
  @override
  final int commentsCount;
  @override
  final List<String> likesId;
  @override
  final List<String> commentsId;
  @override
  final List<String> downloads;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime uploadDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WallpaperModel(id: $id, fileName: $fileName, url: $url, uploaderId: $uploaderId, uploaderName: $uploaderName, downloadsCount: $downloadsCount, commentsCount: $commentsCount, likesId: $likesId, commentsId: $commentsId, downloads: $downloads, uploadDate: $uploadDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WallpaperModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('fileName', fileName))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('uploaderId', uploaderId))
      ..add(DiagnosticsProperty('uploaderName', uploaderName))
      ..add(DiagnosticsProperty('downloadsCount', downloadsCount))
      ..add(DiagnosticsProperty('commentsCount', commentsCount))
      ..add(DiagnosticsProperty('likesId', likesId))
      ..add(DiagnosticsProperty('commentsId', commentsId))
      ..add(DiagnosticsProperty('downloads', downloads))
      ..add(DiagnosticsProperty('uploadDate', uploadDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WallpaperModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.fileName, fileName) ||
                const DeepCollectionEquality()
                    .equals(other.fileName, fileName)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.uploaderId, uploaderId) ||
                const DeepCollectionEquality()
                    .equals(other.uploaderId, uploaderId)) &&
            (identical(other.uploaderName, uploaderName) ||
                const DeepCollectionEquality()
                    .equals(other.uploaderName, uploaderName)) &&
            (identical(other.downloadsCount, downloadsCount) ||
                const DeepCollectionEquality()
                    .equals(other.downloadsCount, downloadsCount)) &&
            (identical(other.commentsCount, commentsCount) ||
                const DeepCollectionEquality()
                    .equals(other.commentsCount, commentsCount)) &&
            (identical(other.likesId, likesId) ||
                const DeepCollectionEquality()
                    .equals(other.likesId, likesId)) &&
            (identical(other.commentsId, commentsId) ||
                const DeepCollectionEquality()
                    .equals(other.commentsId, commentsId)) &&
            (identical(other.downloads, downloads) ||
                const DeepCollectionEquality()
                    .equals(other.downloads, downloads)) &&
            (identical(other.uploadDate, uploadDate) ||
                const DeepCollectionEquality()
                    .equals(other.uploadDate, uploadDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(fileName) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(uploaderId) ^
      const DeepCollectionEquality().hash(uploaderName) ^
      const DeepCollectionEquality().hash(downloadsCount) ^
      const DeepCollectionEquality().hash(commentsCount) ^
      const DeepCollectionEquality().hash(likesId) ^
      const DeepCollectionEquality().hash(commentsId) ^
      const DeepCollectionEquality().hash(downloads) ^
      const DeepCollectionEquality().hash(uploadDate);

  @override
  _$WallpaperModelCopyWith<_WallpaperModel> get copyWith =>
      __$WallpaperModelCopyWithImpl<_WallpaperModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WallpaperModelToJson(this);
  }
}

abstract class _WallpaperModel implements WallpaperModel {
  const factory _WallpaperModel(
      {String id,
      String fileName,
      String url,
      String uploaderId,
      String uploaderName,
      int downloadsCount,
      int commentsCount,
      List<String> likesId,
      List<String> commentsId,
      List<String> downloads,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime uploadDate}) = _$_WallpaperModel;

  factory _WallpaperModel.fromJson(Map<String, dynamic> json) =
      _$_WallpaperModel.fromJson;

  @override
  String get id;
  @override
  String get fileName;
  @override
  String get url;
  @override
  String get uploaderId;
  @override
  String get uploaderName;
  @override
  int get downloadsCount;
  @override
  int get commentsCount;
  @override
  List<String> get likesId;
  @override
  List<String> get commentsId;
  @override
  List<String> get downloads;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get uploadDate;
  @override
  _$WallpaperModelCopyWith<_WallpaperModel> get copyWith;
}
