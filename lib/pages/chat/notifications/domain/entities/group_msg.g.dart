// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMsgNotification _$GroupMsgNotificationFromJson(Map<String, dynamic> json) {
  return GroupMsgNotification(
    type: json['type'],
    id: json['id'] as String,
    sendTo: json['sendTo'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    message: json['message'] as String,
    time: GroupMsgNotification._timeFromJson(json['time']),
    groupId: json['groupId'] as String,
    groupName: json['groupName'] as String,
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$GroupMsgNotificationToJson(
        GroupMsgNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sendTo': instance.sendTo,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'groupName': instance.groupName,
      'groupId': instance.groupId,
      'message': instance.message,
      'id': instance.id,
      'read': instance.read,
      'time': GroupMsgNotification._timeToJson(instance.time),
    };
