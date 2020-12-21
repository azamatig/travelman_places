import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../export.dart';

part 'message.g.dart';
part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    String id,
    String senderId,
    String senderName,
    String senderPhotoUrl,
    String sendTo,
    String content,
    String localPath,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime time,
    List<String> visibleTo,
    bool read,
    int type,
    String chatId,
  }) = _Message;

  static Message fromUser({
    User currentUser,
    String sendToId,
    String content,
    int type,
    String localPath,
  }) {
    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: getChatId(currentUser.id, sendToId),
      senderPhotoUrl: currentUser.photoUrl,
      senderName: currentUser.name,
      sendTo: sendToId,
      visibleTo: [sendToId, currentUser.id],
      senderId: currentUser.id,
      time: DateTime.now(),
      content: content,
      type: type,
      read: false,
      localPath: localPath,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static String getChatId(String i1, String i2) =>
      i1.compareTo(i2) <= -1 ? '$i1$i2' : '$i2$i1';
}

extension MEx on _Message {
  String get chatId => Message.getChatId(senderId, sendTo);
}

enum MessageType {
  Text,
  Image,
  Voice,
  Video,
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
