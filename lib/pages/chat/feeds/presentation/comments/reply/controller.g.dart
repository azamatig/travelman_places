// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReplyController on _ReplyControllerBase, Store {
  final _$offsetAtom = Atom(name: '_ReplyControllerBase.offset');

  @override
  int get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(int value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  final _$addReplyCommentAsyncAction =
      AsyncAction('_ReplyControllerBase.addReplyComment');

  @override
  Future<void> addReplyComment(
      {@required Comment comment, @required String content}) {
    return _$addReplyCommentAsyncAction
        .run(() => super.addReplyComment(comment: comment, content: content));
  }

  final _$removeReplyCommentAsyncAction =
      AsyncAction('_ReplyControllerBase.removeReplyComment');

  @override
  Future<void> removeReplyComment(String parentId, Comment reply) {
    return _$removeReplyCommentAsyncAction
        .run(() => super.removeReplyComment(parentId, reply));
  }

  @override
  String toString() {
    return '''
offset: ${offset}
    ''';
  }
}
