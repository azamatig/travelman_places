import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../export.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    String id,
    String groupId,
    String senderPicUrl,
    String senderId,
    String senderName,
    String content,
    String localPath,
    int type,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
    @JsonKey(defaultValue: <String>[]) List<String> seenBy,
  }) = _Message;

  static Message fromUser({
    User currentUser,
    String groupId,
    String content,
    int type,
    String localPath,
  }) {
    return Message(
      id: '${DateTime.now().toUtc().millisecondsSinceEpoch}-${currentUser.name}',
      groupId: groupId,
      senderPicUrl: currentUser.photoUrl,
      senderId: currentUser.id,
      senderName: currentUser.name,
      time: DateTime.now().toUtc(),
      content: content,
      type: type,
      localPath: localPath,
      seenBy: [currentUser.id],
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
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

String _timeToJson(DateTime time) => time.toUtc().toIso8601String();
