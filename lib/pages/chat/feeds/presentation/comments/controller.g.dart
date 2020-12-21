// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommentsController on _CommentsController, Store {
  final _$commentsAtom = Atom(name: '_CommentsController.comments');

  @override
  ObservableList<Comment> get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(ObservableList<Comment> value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
    });
  }

  final _$commentsOffsetAtom = Atom(name: '_CommentsController.commentsOffset');

  @override
  int get commentsOffset {
    _$commentsOffsetAtom.reportRead();
    return super.commentsOffset;
  }

  @override
  set commentsOffset(int value) {
    _$commentsOffsetAtom.reportWrite(value, super.commentsOffset, () {
      super.commentsOffset = value;
    });
  }

  final _$onRefreshAsyncAction = AsyncAction('_CommentsController.onRefresh');

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  final _$addCommentAsyncAction = AsyncAction('_CommentsController.addComment');

  @override
  Future<void> addComment(String content) {
    return _$addCommentAsyncAction.run(() => super.addComment(content));
  }

  final _$editCommentAsyncAction =
      AsyncAction('_CommentsController.editComment');

  @override
  Future<void> editComment(Comment comment) {
    return _$editCommentAsyncAction.run(() => super.editComment(comment));
  }

  final _$deleteCommentAsyncAction =
      AsyncAction('_CommentsController.deleteComment');

  @override
  Future<void> deleteComment(String commentId) {
    return _$deleteCommentAsyncAction.run(() => super.deleteComment(commentId));
  }

  final _$addOrRemoveReactionAsyncAction =
      AsyncAction('_CommentsController.addOrRemoveReaction');

  @override
  Future<void> addOrRemoveReaction(Comment comment) {
    return _$addOrRemoveReactionAsyncAction
        .run(() => super.addOrRemoveReaction(comment));
  }

  @override
  String toString() {
    return '''
comments: ${comments},
commentsOffset: ${commentsOffset}
    ''';
  }
}
