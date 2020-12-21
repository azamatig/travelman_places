import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../export.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import 'notification.dart';

part 'follow.g.dart';

@JsonSerializable()
class FollowNotification extends OtakuNotification {
  final String followerId, followerName;

  @override
  final String id, sendToId;
  @override
  final bool read;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;

  FollowNotification({
    type = 0,
    this.id,
    this.sendToId,
    this.followerId,
    this.followerName,
    this.time,
    this.read = false,
  }) : super(
          type: 0,
          id: id,
          time: time,
          sendToId: sendToId,
          read: read,
          fromId: followerId,
          fromName: followerName,
        );

  @override
  String content() => '$followerName ${t.Notifications.start_following}';

  factory FollowNotification.fromJson(Map<String, dynamic> json) =>
      _$FollowNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$FollowNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
