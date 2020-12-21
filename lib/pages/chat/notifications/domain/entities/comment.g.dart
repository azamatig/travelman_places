// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentNotification _$PostCommentNotificationFromJson(
    Map<String, dynamic> json) {
  return PostCommentNotification(
    type: json['type'] as int,
    id: json['id'] as String,
    postAuthor: json['postAuthor'] as String,
    postId: json['postId'] as String,
    commentOwnerId: json['commentOwnerId'] as String,
    commentOwnerName: json['commentOwnerName'] as String,
    time: PostCommentNotification._timeFromJson(json['time']),
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$PostCommentNotificationToJson(
        PostCommentNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'postAuthor': instance.postAuthor,
      'postId': instance.postId,
      'commentOwnerId': instance.commentOwnerId,
      'commentOwnerName': instance.commentOwnerName,
      'id': instance.id,
      'read': instance.read,
      'time': PostCommentNotification._timeToJson(instance.time),
    };
