// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$_$_MessageFromJson(Map<String, dynamic> json) {
  return _$_Message(
    id: json['id'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    senderPhotoUrl: json['senderPhotoUrl'] as String,
    sendTo: json['sendTo'] as String,
    content: json['content'] as String,
    localPath: json['localPath'] as String,
    time: _timeFromJson(json['time']),
    visibleTo: (json['visibleTo'] as List)?.map((e) => e as String)?.toList(),
    read: json['read'] as bool,
    type: json['type'] as int,
    chatId: json['chatId'] as String,
  );
}

Map<String, dynamic> _$_$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderPhotoUrl': instance.senderPhotoUrl,
      'sendTo': instance.sendTo,
      'content': instance.content,
      'localPath': instance.localPath,
      'time': _timeToJson(instance.time),
      'visibleTo': instance.visibleTo,
      'read': instance.read,
      'type': instance.type,
      'chatId': instance.chatId,
    };
