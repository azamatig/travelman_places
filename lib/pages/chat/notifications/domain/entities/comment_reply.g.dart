// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReplyNotification _$CommentReplyNotificationFromJson(
    Map<String, dynamic> json) {
  return CommentReplyNotification(
    type: json['type'],
    id: json['id'] as String,
    postAuthorId: json['postAuthorId'] as String,
    postId: json['postId'] as String,
    commentId: json['commentId'] as String,
    commentOwnerId: json['commentOwnerId'] as String,
    time: CommentReplyNotification._timeFromJson(json['time']),
    replyId: json['replyId'] as String,
    replyOwnerName: json['replyOwnerName'] as String,
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$CommentReplyNotificationToJson(
        CommentReplyNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'read': instance.read,
      'postAuthorId': instance.postAuthorId,
      'postId': instance.postId,
      'commentId': instance.commentId,
      'commentOwnerId': instance.commentOwnerId,
      'replyId': instance.replyId,
      'replyOwnerName': instance.replyOwnerName,
      'time': CommentReplyNotification._timeToJson(instance.time),
    };
