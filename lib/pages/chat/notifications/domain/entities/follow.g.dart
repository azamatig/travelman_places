// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowNotification _$FollowNotificationFromJson(Map<String, dynamic> json) {
  return FollowNotification(
    type: json['type'],
    id: json['id'] as String,
    sendToId: json['sendToId'] as String,
    followerId: json['followerId'] as String,
    followerName: json['followerName'] as String,
    time: FollowNotification._timeFromJson(json['time']),
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$FollowNotificationToJson(FollowNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'followerId': instance.followerId,
      'followerName': instance.followerName,
      'id': instance.id,
      'sendToId': instance.sendToId,
      'read': instance.read,
      'time': FollowNotification._timeToJson(instance.time),
    };
