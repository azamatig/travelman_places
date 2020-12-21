// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

class _$MessageTearOff {
  const _$MessageTearOff();

// ignore: unused_element
  _Message call(
      {String id,
      String groupId,
      String senderPicUrl,
      String senderId,
      String senderName,
      String content,
      String localPath,
      int type,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      @JsonKey(defaultValue: <String>[]) List<String> seenBy}) {
    return _Message(
      id: id,
      groupId: groupId,
      senderPicUrl: senderPicUrl,
      senderId: senderId,
      senderName: senderName,
      content: content,
      localPath: localPath,
      type: type,
      time: time,
      seenBy: seenBy,
    );
  }
}

// ignore: unused_element
const $Message = _$MessageTearOff();

mixin _$Message {
  String get id;
  String get groupId;
  String get senderPicUrl;
  String get senderId;
  String get senderName;
  String get content;
  String get localPath;
  int get type;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get time;
  @JsonKey(defaultValue: <String>[])
  List<String> get seenBy;

  Map<String, dynamic> toJson();
  $MessageCopyWith<Message> get copyWith;
}

abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String groupId,
      String senderPicUrl,
      String senderId,
      String senderName,
      String content,
      String localPath,
      int type,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      @JsonKey(defaultValue: <String>[]) List<String> seenBy});
}

class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object id = freezed,
    Object groupId = freezed,
    Object senderPicUrl = freezed,
    Object senderId = freezed,
    Object senderName = freezed,
    Object content = freezed,
    Object localPath = freezed,
    Object type = freezed,
    Object time = freezed,
    Object seenBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      groupId: groupId == freezed ? _value.groupId : groupId as String,
      senderPicUrl: senderPicUrl == freezed
          ? _value.senderPicUrl
          : senderPicUrl as String,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      content: content == freezed ? _value.content : content as String,
      localPath: localPath == freezed ? _value.localPath : localPath as String,
      type: type == freezed ? _value.type : type as int,
      time: time == freezed ? _value.time : time as DateTime,
      seenBy: seenBy == freezed ? _value.seenBy : seenBy as List<String>,
    ));
  }
}

abstract class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String groupId,
      String senderPicUrl,
      String senderId,
      String senderName,
      String content,
      String localPath,
      int type,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      @JsonKey(defaultValue: <String>[]) List<String> seenBy});
}

class __$MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(_Message _value, $Res Function(_Message) _then)
      : super(_value, (v) => _then(v as _Message));

  @override
  _Message get _value => super._value as _Message;

  @override
  $Res call({
    Object id = freezed,
    Object groupId = freezed,
    Object senderPicUrl = freezed,
    Object senderId = freezed,
    Object senderName = freezed,
    Object content = freezed,
    Object localPath = freezed,
    Object type = freezed,
    Object time = freezed,
    Object seenBy = freezed,
  }) {
    return _then(_Message(
      id: id == freezed ? _value.id : id as String,
      groupId: groupId == freezed ? _value.groupId : groupId as String,
      senderPicUrl: senderPicUrl == freezed
          ? _value.senderPicUrl
          : senderPicUrl as String,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      content: content == freezed ? _value.content : content as String,
      localPath: localPath == freezed ? _value.localPath : localPath as String,
      type: type == freezed ? _value.type : type as int,
      time: time == freezed ? _value.time : time as DateTime,
      seenBy: seenBy == freezed ? _value.seenBy : seenBy as List<String>,
    ));
  }
}

@JsonSerializable()
class _$_Message with DiagnosticableTreeMixin implements _Message {
  const _$_Message(
      {this.id,
      this.groupId,
      this.senderPicUrl,
      this.senderId,
      this.senderName,
      this.content,
      this.localPath,
      this.type,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.time,
      @JsonKey(defaultValue: <String>[]) this.seenBy});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$_$_MessageFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String senderPicUrl;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String content;
  @override
  final String localPath;
  @override
  final int type;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  @override
  @JsonKey(defaultValue: <String>[])
  final List<String> seenBy;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message(id: $id, groupId: $groupId, senderPicUrl: $senderPicUrl, senderId: $senderId, senderName: $senderName, content: $content, localPath: $localPath, type: $type, time: $time, seenBy: $seenBy)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('senderPicUrl', senderPicUrl))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('senderName', senderName))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('localPath', localPath))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('seenBy', seenBy));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Message &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality()
                    .equals(other.groupId, groupId)) &&
            (identical(other.senderPicUrl, senderPicUrl) ||
                const DeepCollectionEquality()
                    .equals(other.senderPicUrl, senderPicUrl)) &&
            (identical(other.senderId, senderId) ||
                const DeepCollectionEquality()
                    .equals(other.senderId, senderId)) &&
            (identical(other.senderName, senderName) ||
                const DeepCollectionEquality()
                    .equals(other.senderName, senderName)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.localPath, localPath) ||
                const DeepCollectionEquality()
                    .equals(other.localPath, localPath)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.seenBy, seenBy) ||
                const DeepCollectionEquality().equals(other.seenBy, seenBy)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(senderPicUrl) ^
      const DeepCollectionEquality().hash(senderId) ^
      const DeepCollectionEquality().hash(senderName) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(localPath) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(seenBy);

  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MessageToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {String id,
      String groupId,
      String senderPicUrl,
      String senderId,
      String senderName,
      String content,
      String localPath,
      int type,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      @JsonKey(defaultValue: <String>[]) List<String> seenBy}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get senderPicUrl;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String get content;
  @override
  String get localPath;
  @override
  int get type;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get time;
  @override
  @JsonKey(defaultValue: <String>[])
  List<String> get seenBy;
  @override
  _$MessageCopyWith<_Message> get copyWith;
}
