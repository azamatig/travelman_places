import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../export.dart';
import 'notification.dart';

part 'post_reaction.g.dart';

@JsonSerializable()
class PostReactionNotification extends OtakuNotification {
  final String postAuthor, postId, likeOwnerId, likeOwnerName;
  @override
  final String id;
  @override
  final bool read;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;

  PostReactionNotification({
    type = 1,
    this.id,
    this.postAuthor,
    this.postId,
    this.likeOwnerId,
    this.likeOwnerName,
    this.time,
    this.read = false,
  }) : super(
          type: type,
          id: id,
          time: time,
          sendToId: postAuthor,
          read: read,
          fromId: likeOwnerId,
          fromName: likeOwnerName,
        );

  @override
  String content() => '$likeOwnerName ${t.Notifications.likes_post}!';

  factory PostReactionNotification.fromJson(Map<String, dynamic> json) =>
      _$PostReactionNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$PostReactionNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
