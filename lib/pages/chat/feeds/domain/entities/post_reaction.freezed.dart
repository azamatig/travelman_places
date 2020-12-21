// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'post_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
PostReaction _$PostReactionFromJson(Map<String, dynamic> json) {
  return _PostReaction.fromJson(json);
}

class _$PostReactionTearOff {
  const _$PostReactionTearOff();

// ignore: unused_element
  _PostReaction call(
      {String id,
      String postId,
      String postOwnerId,
      String postOwnerName,
      String reactionOwnerId,
      String reactionOwnerName,
      String reactionOwnerPhotoUrl,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime publishDate}) {
    return _PostReaction(
      id: id,
      postId: postId,
      postOwnerId: postOwnerId,
      postOwnerName: postOwnerName,
      reactionOwnerId: reactionOwnerId,
      reactionOwnerName: reactionOwnerName,
      reactionOwnerPhotoUrl: reactionOwnerPhotoUrl,
      publishDate: publishDate,
    );
  }
}

// ignore: unused_element
const $PostReaction = _$PostReactionTearOff();

mixin _$PostReaction {
  String get id;
  String get postId;
  String get postOwnerId;
  String get postOwnerName;
  String get reactionOwnerId;
  String get reactionOwnerName;
  String get reactionOwnerPhotoUrl;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get publishDate;

  Map<String, dynamic> toJson();
  $PostReactionCopyWith<PostReaction> get copyWith;
}

abstract class $PostReactionCopyWith<$Res> {
  factory $PostReactionCopyWith(
          PostReaction value, $Res Function(PostReaction) then) =
      _$PostReactionCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String postId,
      String postOwnerId,
      String postOwnerName,
      String reactionOwnerId,
      String reactionOwnerName,
      String reactionOwnerPhotoUrl,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime publishDate});
}

class _$PostReactionCopyWithImpl<$Res> implements $PostReactionCopyWith<$Res> {
  _$PostReactionCopyWithImpl(this._value, this._then);

  final PostReaction _value;
  // ignore: unused_field
  final $Res Function(PostReaction) _then;

  @override
  $Res call({
    Object id = freezed,
    Object postId = freezed,
    Object postOwnerId = freezed,
    Object postOwnerName = freezed,
    Object reactionOwnerId = freezed,
    Object reactionOwnerName = freezed,
    Object reactionOwnerPhotoUrl = freezed,
    Object publishDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      postId: postId == freezed ? _value.postId : postId as String,
      postOwnerId:
          postOwnerId == freezed ? _value.postOwnerId : postOwnerId as String,
      postOwnerName: postOwnerName == freezed
          ? _value.postOwnerName
          : postOwnerName as String,
      reactionOwnerId: reactionOwnerId == freezed
          ? _value.reactionOwnerId
          : reactionOwnerId as String,
      reactionOwnerName: reactionOwnerName == freezed
          ? _value.reactionOwnerName
          : reactionOwnerName as String,
      reactionOwnerPhotoUrl: reactionOwnerPhotoUrl == freezed
          ? _value.reactionOwnerPhotoUrl
          : reactionOwnerPhotoUrl as String,
      publishDate:
          publishDate == freezed ? _value.publishDate : publishDate as DateTime,
    ));
  }
}

abstract class _$PostReactionCopyWith<$Res>
    implements $PostReactionCopyWith<$Res> {
  factory _$PostReactionCopyWith(
          _PostReaction value, $Res Function(_PostReaction) then) =
      __$PostReactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String postId,
      String postOwnerId,
      String postOwnerName,
      String reactionOwnerId,
      String reactionOwnerName,
      String reactionOwnerPhotoUrl,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime publishDate});
}

class __$PostReactionCopyWithImpl<$Res> extends _$PostReactionCopyWithImpl<$Res>
    implements _$PostReactionCopyWith<$Res> {
  __$PostReactionCopyWithImpl(
      _PostReaction _value, $Res Function(_PostReaction) _then)
      : super(_value, (v) => _then(v as _PostReaction));

  @override
  _PostReaction get _value => super._value as _PostReaction;

  @override
  $Res call({
    Object id = freezed,
    Object postId = freezed,
    Object postOwnerId = freezed,
    Object postOwnerName = freezed,
    Object reactionOwnerId = freezed,
    Object reactionOwnerName = freezed,
    Object reactionOwnerPhotoUrl = freezed,
    Object publishDate = freezed,
  }) {
    return _then(_PostReaction(
      id: id == freezed ? _value.id : id as String,
      postId: postId == freezed ? _value.postId : postId as String,
      postOwnerId:
          postOwnerId == freezed ? _value.postOwnerId : postOwnerId as String,
      postOwnerName: postOwnerName == freezed
          ? _value.postOwnerName
          : postOwnerName as String,
      reactionOwnerId: reactionOwnerId == freezed
          ? _value.reactionOwnerId
          : reactionOwnerId as String,
      reactionOwnerName: reactionOwnerName == freezed
          ? _value.reactionOwnerName
          : reactionOwnerName as String,
      reactionOwnerPhotoUrl: reactionOwnerPhotoUrl == freezed
          ? _value.reactionOwnerPhotoUrl
          : reactionOwnerPhotoUrl as String,
      publishDate:
          publishDate == freezed ? _value.publishDate : publishDate as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_PostReaction with DiagnosticableTreeMixin implements _PostReaction {
  const _$_PostReaction(
      {this.id,
      this.postId,
      this.postOwnerId,
      this.postOwnerName,
      this.reactionOwnerId,
      this.reactionOwnerName,
      this.reactionOwnerPhotoUrl,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.publishDate});

  factory _$_PostReaction.fromJson(Map<String, dynamic> json) =>
      _$_$_PostReactionFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String postOwnerId;
  @override
  final String postOwnerName;
  @override
  final String reactionOwnerId;
  @override
  final String reactionOwnerName;
  @override
  final String reactionOwnerPhotoUrl;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime publishDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostReaction(id: $id, postId: $postId, postOwnerId: $postOwnerId, postOwnerName: $postOwnerName, reactionOwnerId: $reactionOwnerId, reactionOwnerName: $reactionOwnerName, reactionOwnerPhotoUrl: $reactionOwnerPhotoUrl, publishDate: $publishDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostReaction'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('postOwnerId', postOwnerId))
      ..add(DiagnosticsProperty('postOwnerName', postOwnerName))
      ..add(DiagnosticsProperty('reactionOwnerId', reactionOwnerId))
      ..add(DiagnosticsProperty('reactionOwnerName', reactionOwnerName))
      ..add(DiagnosticsProperty('reactionOwnerPhotoUrl', reactionOwnerPhotoUrl))
      ..add(DiagnosticsProperty('publishDate', publishDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PostReaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.postId, postId) ||
                const DeepCollectionEquality().equals(other.postId, postId)) &&
            (identical(other.postOwnerId, postOwnerId) ||
                const DeepCollectionEquality()
                    .equals(other.postOwnerId, postOwnerId)) &&
            (identical(other.postOwnerName, postOwnerName) ||
                const DeepCollectionEquality()
                    .equals(other.postOwnerName, postOwnerName)) &&
            (identical(other.reactionOwnerId, reactionOwnerId) ||
                const DeepCollectionEquality()
                    .equals(other.reactionOwnerId, reactionOwnerId)) &&
            (identical(other.reactionOwnerName, reactionOwnerName) ||
                const DeepCollectionEquality()
                    .equals(other.reactionOwnerName, reactionOwnerName)) &&
            (identical(other.reactionOwnerPhotoUrl, reactionOwnerPhotoUrl) ||
                const DeepCollectionEquality().equals(
                    other.reactionOwnerPhotoUrl, reactionOwnerPhotoUrl)) &&
            (identical(other.publishDate, publishDate) ||
                const DeepCollectionEquality()
                    .equals(other.publishDate, publishDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(postId) ^
      const DeepCollectionEquality().hash(postOwnerId) ^
      const DeepCollectionEquality().hash(postOwnerName) ^
      const DeepCollectionEquality().hash(reactionOwnerId) ^
      const DeepCollectionEquality().hash(reactionOwnerName) ^
      const DeepCollectionEquality().hash(reactionOwnerPhotoUrl) ^
      const DeepCollectionEquality().hash(publishDate);

  @override
  _$PostReactionCopyWith<_PostReaction> get copyWith =>
      __$PostReactionCopyWithImpl<_PostReaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PostReactionToJson(this);
  }
}

abstract class _PostReaction implements PostReaction {
  const factory _PostReaction(
      {String id,
      String postId,
      String postOwnerId,
      String postOwnerName,
      String reactionOwnerId,
      String reactionOwnerName,
      String reactionOwnerPhotoUrl,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime publishDate}) = _$_PostReaction;

  factory _PostReaction.fromJson(Map<String, dynamic> json) =
      _$_PostReaction.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get postOwnerId;
  @override
  String get postOwnerName;
  @override
  String get reactionOwnerId;
  @override
  String get reactionOwnerName;
  @override
  String get reactionOwnerPhotoUrl;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get publishDate;
  @override
  _$PostReactionCopyWith<_PostReaction> get copyWith;
}
