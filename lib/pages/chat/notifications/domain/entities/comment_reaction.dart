import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../export.dart';
import 'notification.dart';

part 'comment_reaction.g.dart';

@JsonSerializable()
class CommentReactionNotification extends OtakuNotification {
  @override
  final String id;
  @override
  final bool read;

  final String postAuthorId,
      postId,
      commentOwnerId,
      reactionOwnerId,
      reactionOwnerName;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;

  CommentReactionNotification({
    type = 5,
    this.id,
    this.postAuthorId,
    this.postId,
    this.commentOwnerId,
    this.time,
    this.reactionOwnerId,
    this.reactionOwnerName,
    this.read = false,
  }) : super(
          type: type,
          id: id,
          time: time,
          sendToId: commentOwnerId,
          read: read,
          fromId: reactionOwnerId,
          fromName: reactionOwnerName,
        );

  @override
  String content() => '$reactionOwnerName ${t.Notifications.liked_comment}!';

  factory CommentReactionNotification.fromJson(Map<String, dynamic> json) =>
      _$CommentReactionNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$CommentReactionNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
