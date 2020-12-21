// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'upload_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$UploadStateTearOff {
  const _$UploadStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _WallpaperPicked wallpaperPicked(String path) {
    return _WallpaperPicked(
      path,
    );
  }

// ignore: unused_element
  _Uploading uploading() {
    return const _Uploading();
  }

// ignore: unused_element
  _Success success(String url) {
    return _Success(
      url,
    );
  }

// ignore: unused_element
  _Failed failed() {
    return const _Failed();
  }
}

// ignore: unused_element
const $UploadState = _$UploadStateTearOff();

mixin _$UploadState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  });
}

abstract class $UploadStateCopyWith<$Res> {
  factory $UploadStateCopyWith(
          UploadState value, $Res Function(UploadState) then) =
      _$UploadStateCopyWithImpl<$Res>;
}

class _$UploadStateCopyWithImpl<$Res> implements $UploadStateCopyWith<$Res> {
  _$UploadStateCopyWithImpl(this._value, this._then);

  final UploadState _value;
  // ignore: unused_field
  final $Res Function(UploadState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'UploadState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UploadState {
  const factory _Initial() = _$_Initial;
}

abstract class _$WallpaperPickedCopyWith<$Res> {
  factory _$WallpaperPickedCopyWith(
          _WallpaperPicked value, $Res Function(_WallpaperPicked) then) =
      __$WallpaperPickedCopyWithImpl<$Res>;
  $Res call({String path});
}

class __$WallpaperPickedCopyWithImpl<$Res>
    extends _$UploadStateCopyWithImpl<$Res>
    implements _$WallpaperPickedCopyWith<$Res> {
  __$WallpaperPickedCopyWithImpl(
      _WallpaperPicked _value, $Res Function(_WallpaperPicked) _then)
      : super(_value, (v) => _then(v as _WallpaperPicked));

  @override
  _WallpaperPicked get _value => super._value as _WallpaperPicked;

  @override
  $Res call({
    Object path = freezed,
  }) {
    return _then(_WallpaperPicked(
      path == freezed ? _value.path : path as String,
    ));
  }
}

class _$_WallpaperPicked implements _WallpaperPicked {
  const _$_WallpaperPicked(this.path) : assert(path != null);

  @override
  final String path;

  @override
  String toString() {
    return 'UploadState.wallpaperPicked(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WallpaperPicked &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(path);

  @override
  _$WallpaperPickedCopyWith<_WallpaperPicked> get copyWith =>
      __$WallpaperPickedCopyWithImpl<_WallpaperPicked>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return wallpaperPicked(path);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (wallpaperPicked != null) {
      return wallpaperPicked(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return wallpaperPicked(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (wallpaperPicked != null) {
      return wallpaperPicked(this);
    }
    return orElse();
  }
}

abstract class _WallpaperPicked implements UploadState {
  const factory _WallpaperPicked(String path) = _$_WallpaperPicked;

  String get path;
  _$WallpaperPickedCopyWith<_WallpaperPicked> get copyWith;
}

abstract class _$UploadingCopyWith<$Res> {
  factory _$UploadingCopyWith(
          _Uploading value, $Res Function(_Uploading) then) =
      __$UploadingCopyWithImpl<$Res>;
}

class __$UploadingCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$UploadingCopyWith<$Res> {
  __$UploadingCopyWithImpl(_Uploading _value, $Res Function(_Uploading) _then)
      : super(_value, (v) => _then(v as _Uploading));

  @override
  _Uploading get _value => super._value as _Uploading;
}

class _$_Uploading implements _Uploading {
  const _$_Uploading();

  @override
  String toString() {
    return 'UploadState.uploading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Uploading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return uploading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (uploading != null) {
      return uploading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return uploading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (uploading != null) {
      return uploading(this);
    }
    return orElse();
  }
}

abstract class _Uploading implements UploadState {
  const factory _Uploading() = _$_Uploading;
}

abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  $Res call({String url});
}

class __$SuccessCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object url = freezed,
  }) {
    return _then(_Success(
      url == freezed ? _value.url : url as String,
    ));
  }
}

class _$_Success implements _Success {
  const _$_Success(this.url) : assert(url != null);

  @override
  final String url;

  @override
  String toString() {
    return 'UploadState.success(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Success &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(url);

  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return success(url);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements UploadState {
  const factory _Success(String url) = _$_Success;

  String get url;
  _$SuccessCopyWith<_Success> get copyWith;
}

abstract class _$FailedCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
}

class __$FailedCopyWithImpl<$Res> extends _$UploadStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;
}

class _$_Failed implements _Failed {
  const _$_Failed();

  @override
  String toString() {
    return 'UploadState.failed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Failed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result wallpaperPicked(String path),
    @required Result uploading(),
    @required Result success(String url),
    @required Result failed(),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return failed();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result wallpaperPicked(String path),
    Result uploading(),
    Result success(String url),
    Result failed(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failed != null) {
      return failed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result wallpaperPicked(_WallpaperPicked value),
    @required Result uploading(_Uploading value),
    @required Result success(_Success value),
    @required Result failed(_Failed value),
  }) {
    assert(initial != null);
    assert(wallpaperPicked != null);
    assert(uploading != null);
    assert(success != null);
    assert(failed != null);
    return failed(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result wallpaperPicked(_WallpaperPicked value),
    Result uploading(_Uploading value),
    Result success(_Success value),
    Result failed(_Failed value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements UploadState {
  const factory _Failed() = _$_Failed;
}
