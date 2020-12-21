// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String,
    authorId: json['authorId'] as String,
    authorName: json['authorName'] as String,
    authorPhotoUrl: json['authorPhotoUrl'] as String,
    publishDate: _timeFromJson(json['publishDate']),
    content: json['content'] as String,
    imgUrl: json['imgUrl'] as String,
    hasImage: json['hasImage'] as bool,
    usersLikes: (json['usersLikes'] as List)?.map((e) => e as String)?.toList(),
    commentsIds:
        (json['commentsIds'] as List)?.map((e) => e as String)?.toList(),
    reportUsers:
        (json['reportUsers'] as List)?.map((e) => e as String)?.toList() ?? [],
    updatedDate: _timeFromJson(json['updatedDate']),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'content': instance.content,
      'imgUrl': instance.imgUrl,
      'usersLikes': instance.usersLikes,
      'commentsIds': instance.commentsIds,
      'hasImage': instance.hasImage,
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorPhotoUrl': instance.authorPhotoUrl,
      'publishDate': _timeToJson(instance.publishDate),
      'updatedDate': _timeToJson(instance.updatedDate),
      'reportUsers': instance.reportUsers,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Post on _Post, Store {
  Computed<bool> _$hasImageComputed;

  @override
  bool get hasImage => (_$hasImageComputed ??=
          Computed<bool>(() => super.hasImage, name: '_Post.hasImage'))
      .value;

  final _$contentAtom = Atom(name: '_Post.content');

  @override
  String get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  final _$imgUrlAtom = Atom(name: '_Post.imgUrl');

  @override
  String get imgUrl {
    _$imgUrlAtom.reportRead();
    return super.imgUrl;
  }

  @override
  set imgUrl(String value) {
    _$imgUrlAtom.reportWrite(value, super.imgUrl, () {
      super.imgUrl = value;
    });
  }

  final _$usersLikesAtom = Atom(name: '_Post.usersLikes');

  @override
  ObservableList<String> get usersLikes {
    _$usersLikesAtom.reportRead();
    return super.usersLikes;
  }

  @override
  set usersLikes(ObservableList<String> value) {
    _$usersLikesAtom.reportWrite(value, super.usersLikes, () {
      super.usersLikes = value;
    });
  }

  final _$commentsIdsAtom = Atom(name: '_Post.commentsIds');

  @override
  List<String> get commentsIds {
    _$commentsIdsAtom.reportRead();
    return super.commentsIds;
  }

  @override
  set commentsIds(List<String> value) {
    _$commentsIdsAtom.reportWrite(value, super.commentsIds, () {
      super.commentsIds = value;
    });
  }

  @override
  String toString() {
    return '''
content: ${content},
imgUrl: ${imgUrl},
usersLikes: ${usersLikes},
commentsIds: ${commentsIds},
hasImage: ${hasImage}
    ''';
  }
}
