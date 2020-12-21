import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../export.dart';
import 'notification.dart';

part 'chat_msg.g.dart';

@JsonSerializable()
class ChatMsgNotification extends OtakuNotification {
  final String sendTo, senderId, senderName, message;

  @override
  final String id;

  @override
  final bool read;

  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime time;
  ChatMsgNotification({
    type = 3,
    this.id,
    this.sendTo,
    this.senderId,
    this.senderName,
    this.message,
    this.time,
    this.read = false,
  }) : super(
            type: 3,
            id: id,
            time: time,
            sendToId: senderId,
            read: read,
            fromId: senderId,
            fromName: senderName);

  @override
  String content() => '$senderName ${t.Notifications.sent_msg}!';

  factory ChatMsgNotification.fromJson(Map<String, dynamic> json) =>
      _$ChatMsgNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMsgNotificationToJson(this);

  static DateTime _timeFromJson(ts) => ts == null
      ? null
      : ts is Timestamp
          ? ts?.toDate()?.toLocal()
          : DateTime.parse(ts as String).toLocal();

  static DateTime _timeToJson(DateTime time) => time.toUtc();
}
