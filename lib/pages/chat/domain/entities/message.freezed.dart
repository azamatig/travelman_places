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
      String senderId,
      String senderName,
      String senderPhotoUrl,
      String sendTo,
      String content,
      String localPath,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      List<String> visibleTo,
      bool read,
      int type,
      String chatId}) {
    return _Message(
      id: id,
      senderId: senderId,
      senderName: senderName,
      senderPhotoUrl: senderPhotoUrl,
      sendTo: sendTo,
      content: content,
      localPath: localPath,
      time: time,
      visibleTo: visibleTo,
      read: read,
      type: type,
      chatId: chatId,
    );
  }
}

// ignore: unused_element
const $Message = _$MessageTearOff();

mixin _$Message {
  String get id;
  String get senderId;
  String get senderName;
  String get senderPhotoUrl;
  String get sendTo;
  String get content;
  String get localPath;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get time;
  List<String> get visibleTo;
  bool get read;
  int get type;
  String get chatId;

  Map<String, dynamic> toJson();
  $MessageCopyWith<Message> get copyWith;
}

abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String senderId,
      String senderName,
      String senderPhotoUrl,
      String sendTo,
      String content,
      String localPath,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      List<String> visibleTo,
      bool read,
      int type,
      String chatId});
}

class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object id = freezed,
    Object senderId = freezed,
    Object senderName = freezed,
    Object senderPhotoUrl = freezed,
    Object sendTo = freezed,
    Object content = freezed,
    Object localPath = freezed,
    Object time = freezed,
    Object visibleTo = freezed,
    Object read = freezed,
    Object type = freezed,
    Object chatId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      senderPhotoUrl: senderPhotoUrl == freezed
          ? _value.senderPhotoUrl
          : senderPhotoUrl as String,
      sendTo: sendTo == freezed ? _value.sendTo : sendTo as String,
      content: content == freezed ? _value.content : content as String,
      localPath: localPath == freezed ? _value.localPath : localPath as String,
      time: time == freezed ? _value.time : time as DateTime,
      visibleTo:
          visibleTo == freezed ? _value.visibleTo : visibleTo as List<String>,
      read: read == freezed ? _value.read : read as bool,
      type: type == freezed ? _value.type : type as int,
      chatId: chatId == freezed ? _value.chatId : chatId as String,
    ));
  }
}

abstract class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String senderId,
      String senderName,
      String senderPhotoUrl,
      String sendTo,
      String content,
      String localPath,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      List<String> visibleTo,
      bool read,
      int type,
      String chatId});
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
    Object senderId = freezed,
    Object senderName = freezed,
    Object senderPhotoUrl = freezed,
    Object sendTo = freezed,
    Object content = freezed,
    Object localPath = freezed,
    Object time = freezed,
    Object visibleTo = freezed,
    Object read = freezed,
    Object type = freezed,
    Object chatId = freezed,
  }) {
    return _then(_Message(
      id: id == freezed ? _value.id : id as String,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      senderPhotoUrl: senderPhotoUrl == freezed
          ? _value.senderPhotoUrl
          : senderPhotoUrl as String,
      sendTo: sendTo == freezed ? _value.sendTo : sendTo as String,
      content: content == freezed ? _value.content : content as String,
      localPath: localPath == freezed ? _value.localPath : localPath as String,
      time: time == freezed ? _value.time : time as DateTime,
      visibleTo:
          visibleTo == freezed ? _value.visibleTo : visibleTo as List<String>,
      read: read == freezed ? _value.read : read as bool,
      type: type == freezed ? _value.type : type as int,
      chatId: chatId == freezed ? _value.chatId : chatId as String,
    ));
  }
}

@JsonSerializable()
class _$_Message with DiagnosticableTreeMixin implements _Message {
  const _$_Message(
      {this.id,
      this.senderId,
      this.senderName,
      this.senderPhotoUrl,
      this.sendTo,
      this.content,
      this.localPath,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.time,
      this.visibleTo,
      this.read,
      this.type,
      this.chatId});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$_$_MessageFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String senderPhotoUrl;
  @override
  final String sendTo;
  @override
  final String content;
  @override
  final String localPath;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  @override
  final List<String> visibleTo;
  @override
  final bool read;
  @override
  final int type;
  @override
  final String chatId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message(id: $id, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, sendTo: $sendTo, content: $content, localPath: $localPath, time: $time, visibleTo: $visibleTo, read: $read, type: $type, chatId: $chatId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('senderName', senderName))
      ..add(DiagnosticsProperty('senderPhotoUrl', senderPhotoUrl))
      ..add(DiagnosticsProperty('sendTo', sendTo))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('localPath', localPath))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('visibleTo', visibleTo))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('chatId', chatId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Message &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.senderId, senderId) ||
                const DeepCollectionEquality()
                    .equals(other.senderId, senderId)) &&
            (identical(other.senderName, senderName) ||
                const DeepCollectionEquality()
                    .equals(other.senderName, senderName)) &&
            (identical(other.senderPhotoUrl, senderPhotoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.senderPhotoUrl, senderPhotoUrl)) &&
            (identical(other.sendTo, sendTo) ||
                const DeepCollectionEquality().equals(other.sendTo, sendTo)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.localPath, localPath) ||
                const DeepCollectionEquality()
                    .equals(other.localPath, localPath)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.visibleTo, visibleTo) ||
                const DeepCollectionEquality()
                    .equals(other.visibleTo, visibleTo)) &&
            (identical(other.read, read) ||
                const DeepCollectionEquality().equals(other.read, read)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(senderId) ^
      const DeepCollectionEquality().hash(senderName) ^
      const DeepCollectionEquality().hash(senderPhotoUrl) ^
      const DeepCollectionEquality().hash(sendTo) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(localPath) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(visibleTo) ^
      const DeepCollectionEquality().hash(read) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(chatId);

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
      String senderId,
      String senderName,
      String senderPhotoUrl,
      String sendTo,
      String content,
      String localPath,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
      List<String> visibleTo,
      bool read,
      int type,
      String chatId}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String get senderPhotoUrl;
  @override
  String get sendTo;
  @override
  String get content;
  @override
  String get localPath;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get time;
  @override
  List<String> get visibleTo;
  @override
  bool get read;
  @override
  int get type;
  @override
  String get chatId;
  @override
  _$MessageCopyWith<_Message> get copyWith;
}
