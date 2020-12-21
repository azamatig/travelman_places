// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$_$_MessageFromJson(Map<String, dynamic> json) {
  return _$_Message(
    id: json['id'] as String,
    groupId: json['groupId'] as String,
    senderPicUrl: json['senderPicUrl'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    content: json['content'] as String,
    localPath: json['localPath'] as String,
    type: json['type'] as int,
    time: _timeFromJson(json['time']),
    seenBy: (json['seenBy'] as List)?.map((e) => e as String)?.toList() ?? [],
  );
}

Map<String, dynamic> _$_$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'senderPicUrl': instance.senderPicUrl,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'content': instance.content,
      'localPath': instance.localPath,
      'type': instance.type,
      'time': _timeToJson(instance.time),
      'seenBy': instance.seenBy,
    };
