// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMsgNotification _$ChatMsgNotificationFromJson(Map<String, dynamic> json) {
  return ChatMsgNotification(
    type: json['type'],
    id: json['id'] as String,
    sendTo: json['sendTo'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    message: json['message'] as String,
    time: ChatMsgNotification._timeFromJson(json['time']),
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$ChatMsgNotificationToJson(
        ChatMsgNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sendTo': instance.sendTo,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'message': instance.message,
      'id': instance.id,
      'read': instance.read,
      'time': ChatMsgNotification._timeToJson(instance.time),
    };
