// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  final _$postQueryAtom = Atom(name: '_FeedControllerBase.postQuery');

  @override
  PostQuery get postQuery {
    _$postQueryAtom.reportRead();
    return super.postQuery;
  }

  @override
  set postQuery(PostQuery value) {
    _$postQueryAtom.reportWrite(value, super.postQuery, () {
      super.postQuery = value;
    });
  }

  final _$selectedPostAtom = Atom(name: '_FeedControllerBase.selectedPost');

  @override
  Post get selectedPost {
    _$selectedPostAtom.reportRead();
    return super.selectedPost;
  }

  @override
  set selectedPost(Post value) {
    _$selectedPostAtom.reportWrite(value, super.selectedPost, () {
      super.selectedPost = value;
    });
  }

  final _$changePostQueryAsyncAction =
      AsyncAction('_FeedControllerBase.changePostQuery');

  @override
  Future<void> changePostQuery(PostQuery v) {
    return _$changePostQueryAsyncAction.run(() => super.changePostQuery(v));
  }

  @override
  String toString() {
    return '''
postQuery: ${postQuery},
selectedPost: ${selectedPost}
    ''';
  }
}
