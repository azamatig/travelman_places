// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostReaction _$_$_PostReactionFromJson(Map<String, dynamic> json) {
  return _$_PostReaction(
    id: json['id'] as String,
    postId: json['postId'] as String,
    postOwnerId: json['postOwnerId'] as String,
    postOwnerName: json['postOwnerName'] as String,
    reactionOwnerId: json['reactionOwnerId'] as String,
    reactionOwnerName: json['reactionOwnerName'] as String,
    reactionOwnerPhotoUrl: json['reactionOwnerPhotoUrl'] as String,
    publishDate: _timeFromJson(json['publishDate']),
  );
}

Map<String, dynamic> _$_$_PostReactionToJson(_$_PostReaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'postOwnerId': instance.postOwnerId,
      'postOwnerName': instance.postOwnerName,
      'reactionOwnerId': instance.reactionOwnerId,
      'reactionOwnerName': instance.reactionOwnerName,
      'reactionOwnerPhotoUrl': instance.reactionOwnerPhotoUrl,
      'publishDate': _timeToJson(instance.publishDate),
    };
