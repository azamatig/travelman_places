import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../export.dart';
import 'notification.dart';

part 'comment_reply.g.dart';

@JsonSerializable()
class CommentReplyNotification extends OtakuNotification {
  @override
  final String id;

  @override
  final bool read;

  final String postAuthorId,
      postId,
      commentId,
      commentOwnerId,
      replyId,
      replyOwnerName;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;

  CommentReplyNotification(
      {type = 4,
      this.id,
      this.postAuthorId,
      this.postId,
      this.commentId,
      this.commentOwnerId,
      this.time,
      this.replyId,
      this.replyOwnerName,
      this.read = false})
      : super(
          type: type,
          id: id,
          time: time,
          sendToId: commentOwnerId,
          read: read,
          fromId: replyId,
          fromName: replyOwnerName,
        );

  @override
  String content() => '$replyOwnerName ${t.Notifications.replied}';

  factory CommentReplyNotification.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$CommentReplyNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
