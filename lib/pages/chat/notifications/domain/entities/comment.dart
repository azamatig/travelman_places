import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../export.dart';
import 'notification.dart';

part 'comment.g.dart';

@JsonSerializable()
class PostCommentNotification extends OtakuNotification {
  final String postAuthor, postId, commentOwnerId, commentOwnerName;

  @override
  final String id;

  @override
  final bool read;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;

  PostCommentNotification(
      {int type = 2,
      this.id,
      this.postAuthor,
      this.postId,
      this.commentOwnerId,
      this.commentOwnerName,
      this.time,
      this.read = false})
      : super(
          type: type,
          id: id,
          time: time,
          sendToId: postAuthor,
          read: read,
          fromId: commentOwnerId,
          fromName: commentOwnerName,
        );

  @override
  String content() => '$commentOwnerName ${t.Notifications.commented_post}!';

  factory PostCommentNotification.fromJson(Map<String, dynamic> json) =>
      _$PostCommentNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
