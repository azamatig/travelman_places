// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as String,
    postId: json['postId'] as String,
    postAuthorId: json['postAuthorId'] as String,
    authorId: json['authorId'] as String,
    authorName: json['authorName'] as String,
    authorPhotoUrl: json['authorPhotoUrl'] as String,
    publishDate: _timeFromJson(json['publishDate']),
    parentId: json['parentId'] as String,
    content: json['content'] as String,
    usersLikeIds:
        (json['usersLikeIds'] as List)?.map((e) => e as String)?.toList(),
    replyComments: _replyFromJson(json['replyComments'] as List),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'content': instance.content,
      'usersLikeIds': instance.usersLikeIds,
      'id': instance.id,
      'postId': instance.postId,
      'postAuthorId': instance.postAuthorId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorPhotoUrl': instance.authorPhotoUrl,
      'parentId': instance.parentId,
      'publishDate': _timeToJson(instance.publishDate),
      'replyComments': instance.replyComments,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Comment on _Comment, Store {
  final _$contentAtom = Atom(name: '_Comment.content');

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

  final _$usersLikeIdsAtom = Atom(name: '_Comment.usersLikeIds');

  @override
  ObservableList<String> get usersLikeIds {
    _$usersLikeIdsAtom.reportRead();
    return super.usersLikeIds;
  }

  @override
  set usersLikeIds(ObservableList<String> value) {
    _$usersLikeIdsAtom.reportWrite(value, super.usersLikeIds, () {
      super.usersLikeIds = value;
    });
  }

  @override
  String toString() {
    return '''
content: ${content},
usersLikeIds: ${usersLikeIds}
    ''';
  }
}
