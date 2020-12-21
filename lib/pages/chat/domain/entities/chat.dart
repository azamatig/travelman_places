import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'message.dart';

part 'chat.g.dart';
part 'chat.freezed.dart';

@freezed
abstract class Chat with _$Chat {
  const factory Chat({
    String id,
    List<String> users,
    List<String> visibleTo,
    String firstUserName,
    String otherUserName,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime updateTime,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime createdAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  static Chat fromMessage(Message message) {
    return Chat(
      id: message.chatId,
      users: message.visibleTo,
      visibleTo: message.visibleTo,
      updateTime: message.time,
      firstUserName: message.senderName,
      otherUserName: message.sendTo,
      createdAt: message.time,
    );
  }
}

DateTime _timeFromJson(ts) {
  if (ts == null) return DateTime.now();
  switch (ts.runtimeType) {
    case DateTime:
      return ts;
    case Timestamp:
      return ts.toDate().toLocal();
    case String:
      return DateTime.parse(ts as String).toLocal();
    case int:
      return DateTime.fromMillisecondsSinceEpoch(ts).toLocal();
    default:
      return DateTime.now();
  }
}

DateTime _timeToJson(DateTime time) => time;
