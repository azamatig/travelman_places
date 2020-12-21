// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostEditorController on _PostEditorController, Store {
  Computed<bool> _$allowedToPublishComputed;

  @override
  bool get allowedToPublish => (_$allowedToPublishComputed ??= Computed<bool>(
          () => super.allowedToPublish,
          name: '_PostEditorController.allowedToPublish'))
      .value;

  final _$uploadImgListenerAtom =
      Atom(name: '_PostEditorController.uploadImgListener');

  @override
  UploadState get uploadImgListener {
    _$uploadImgListenerAtom.reportRead();
    return super.uploadImgListener;
  }

  @override
  set uploadImgListener(UploadState value) {
    _$uploadImgListenerAtom.reportWrite(value, super.uploadImgListener, () {
      super.uploadImgListener = value;
    });
  }

  final _$addPostAsyncAction = AsyncAction('_PostEditorController.addPost');

  @override
  Future<void> addPost() {
    return _$addPostAsyncAction.run(() => super.addPost());
  }

  final _$updatePostAsyncAction =
      AsyncAction('_PostEditorController.updatePost');

  @override
  Future<void> updatePost() {
    return _$updatePostAsyncAction.run(() => super.updatePost());
  }

  final _$deletePostAsyncAction =
      AsyncAction('_PostEditorController.deletePost');

  @override
  Future<void> deletePost() {
    return _$deletePostAsyncAction.run(() => super.deletePost());
  }

  @override
  String toString() {
    return '''
uploadImgListener: ${uploadImgListener},
allowedToPublish: ${allowedToPublish}
    ''';
  }
}
