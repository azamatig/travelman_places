import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../export.dart';

part 'post_reaction.g.dart';
part 'post_reaction.freezed.dart';

@freezed
abstract class PostReaction with _$PostReaction {
  const factory PostReaction({
    String id,
    String postId,
    String postOwnerId,
    String postOwnerName,
    String reactionOwnerId,
    String reactionOwnerName,
    String reactionOwnerPhotoUrl,
    @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) DateTime publishDate,
  }) = _PostReaction;

  static PostReaction fromUser(User currentUser, Post post) {
    return PostReaction(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.name}',
      postId: post.id,
      postOwnerId: post.authorId,
      postOwnerName: post.authorName,
      reactionOwnerId: currentUser.id,
      reactionOwnerName: currentUser.name,
      reactionOwnerPhotoUrl: currentUser.photoUrl,
      publishDate: DateTime.now().toUtc(),
    );
  }

  factory PostReaction.fromJson(Map<String, dynamic> json) =>
      _$PostReactionFromJson(json);
}

DateTime _timeFromJson(ts) => ts == null
    ? null
    : ts is Timestamp ? ts?.toDate() : DateTime.parse(ts as String);

DateTime _timeToJson(DateTime time) => time;
