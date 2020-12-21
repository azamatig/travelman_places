import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../export.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends _Comment with _$Comment {
  final String id,
      postId,
      postAuthorId,
      authorId,
      authorName,
      authorPhotoUrl,
      parentId;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime publishDate;

  @JsonKey(fromJson: _replyFromJson)
  final List<Comment> replyComments;
  Comment({
    this.id,
    this.postId,
    this.postAuthorId,
    this.authorId,
    this.authorName,
    this.authorPhotoUrl,
    this.publishDate,
    this.parentId,
    String content,
    List<String> usersLikeIds,
    this.replyComments,
  }) : super(
          content,
          ObservableList.of(usersLikeIds ?? <String>[]),
        );

  factory Comment.fromUser({
    User currentUser,
    String content,
    String postId,
    String postAuthorId,
    String parentId,
  }) {
    return Comment(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.name}',
      content: content,
      postId: postId,
      postAuthorId: postAuthorId,
      authorId: currentUser.id,
      authorName: currentUser.name,
      authorPhotoUrl: currentUser.photoUrl,
      publishDate: DateTime.now().toUtc(),
      usersLikeIds: [],
      replyComments: [],
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

abstract class _Comment with Store {
  _Comment(this.content, this.usersLikeIds);
  @observable
  String content;

  @observable
  ObservableList<String> usersLikeIds;
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

List<Comment> _replyFromJson(List list) =>
    list
        ?.map<Comment>((e) => Comment.fromJson(Map<String, dynamic>.from(e)))
        ?.toList() ??
    <Comment>[];
