// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$_$_ChatFromJson(Map<String, dynamic> json) {
  return _$_Chat(
    id: json['id'] as String,
    users: (json['users'] as List)?.map((e) => e as String)?.toList(),
    visibleTo: (json['visibleTo'] as List)?.map((e) => e as String)?.toList(),
    firstUserName: json['firstUserName'] as String,
    otherUserName: json['otherUserName'] as String,
    updateTime: _timeFromJson(json['updateTime']),
    createdAt: _timeFromJson(json['createdAt']),
  );
}

Map<String, dynamic> _$_$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'visibleTo': instance.visibleTo,
      'firstUserName': instance.firstUserName,
      'otherUserName': instance.otherUserName,
      'updateTime': _timeToJson(instance.updateTime),
      'createdAt': _timeToJson(instance.createdAt),
    };
