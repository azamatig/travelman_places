// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReactionNotification _$CommentReactionNotificationFromJson(
    Map<String, dynamic> json) {
  return CommentReactionNotification(
    type: json['type'],
    id: json['id'] as String,
    postAuthorId: json['postAuthorId'] as String,
    postId: json['postId'] as String,
    commentOwnerId: json['commentOwnerId'] as String,
    time: CommentReactionNotification._timeFromJson(json['time']),
    reactionOwnerId: json['reactionOwnerId'] as String,
    reactionOwnerName: json['reactionOwnerName'] as String,
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$CommentReactionNotificationToJson(
        CommentReactionNotification instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'read': instance.read,
      'postAuthorId': instance.postAuthorId,
      'postId': instance.postId,
      'commentOwnerId': instance.commentOwnerId,
      'reactionOwnerId': instance.reactionOwnerId,
      'reactionOwnerName': instance.reactionOwnerName,
      'time': CommentReactionNotification._timeToJson(instance.time),
    };
