import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../export.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends _Post with _$Post {
  final String id, authorId, authorName, authorPhotoUrl;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime publishDate;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime updatedDate;

  @JsonKey(defaultValue: <String>[])
  final List<String> reportUsers;

  Post({
    this.id,
    this.authorId,
    this.authorName,
    this.authorPhotoUrl,
    this.publishDate,
    String content,
    String imgUrl,
    bool hasImage,
    List<String> usersLikes,
    List<String> commentsIds,
    this.reportUsers,
    this.updatedDate,
  }) : super(
          content: content,
          imgUrl: imgUrl,
          usersLikes: ObservableList.of(usersLikes),
          commentsIds: ObservableList.of(commentsIds),
        );

  factory Post.fromUser(User currentUser, String content, String imgUrl) {
    return Post(
      id: '${DateTime.now().millisecondsSinceEpoch}-${currentUser.name}',
      authorId: currentUser.id,
      authorName: currentUser.name,
      authorPhotoUrl: currentUser.photoUrl,
      content: content,
      imgUrl: imgUrl,
      hasImage: imgUrl?.isNotEmpty == true,
      usersLikes: [],
      publishDate: DateTime.now().toUtc(),
      updatedDate: DateTime.now().toUtc(),
      commentsIds: [],
      reportUsers: [],
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  PostType typeFromString(s) {
    switch (s) {
      case 'Story':
        return PostType.Story;
      case 'Art':
        return PostType.Art;
      default:
        return PostType.Normal;
    }
  }
}

enum PostType {
  Story,
  Art,
  Normal,
}

abstract class _Post with Store {
  @observable
  String content;

  @observable
  String imgUrl;

  @observable
  ObservableList<String> usersLikes;

  @observable
  List<String> commentsIds;

  _Post({this.content, this.imgUrl, this.usersLikes, this.commentsIds});

  @computed
  bool get hasImage => imgUrl?.isNotEmpty == true;
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
