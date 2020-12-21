// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReactionNotification _$PostReactionNotificationFromJson(
    Map<String, dynamic> json) {
  return PostReactionNotification(
    type: json['type'],
    id: json['id'] as String,
    postAuthor: json['postAuthor'] as String,
    postId: json['postId'] as String,
    likeOwnerId: json['likeOwnerId'] as String,
    likeOwnerName: json['likeOwnerName'] as String,
    time: PostReactionNotification._timeFromJson(json['time']),
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$PostReactionNotificationToJson(
        PostReactionNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'postAuthor': instance.postAuthor,
      'postId': instance.postId,
      'likeOwnerId': instance.likeOwnerId,
      'likeOwnerName': instance.likeOwnerName,
      'id': instance.id,
      'read': instance.read,
      'time': PostReactionNotification._timeToJson(instance.time),
    };
