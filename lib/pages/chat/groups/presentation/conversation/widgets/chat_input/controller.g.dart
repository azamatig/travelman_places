// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatInputController on _ChatInputController, Store {
  final _$isImageUploadingAtom =
      Atom(name: '_ChatInputController.isImageUploading');

  @override
  bool get isImageUploading {
    _$isImageUploadingAtom.reportRead();
    return super.isImageUploading;
  }

  @override
  set isImageUploading(bool value) {
    _$isImageUploadingAtom.reportWrite(value, super.isImageUploading, () {
      super.isImageUploading = value;
    });
  }

  final _$isTypingAtom = Atom(name: '_ChatInputController.isTyping');

  @override
  bool get isTyping {
    _$isTypingAtom.reportRead();
    return super.isTyping;
  }

  @override
  set isTyping(bool value) {
    _$isTypingAtom.reportWrite(value, super.isTyping, () {
      super.isTyping = value;
    });
  }

  final _$onSendMessageAsyncAction =
      AsyncAction('_ChatInputController.onSendMessage');

  @override
  Future<void> onSendMessage({String message}) {
    return _$onSendMessageAsyncAction
        .run(() => super.onSendMessage(message: message));
  }

  final _$onSendImageAsyncAction =
      AsyncAction('_ChatInputController.onSendImage');

  @override
  Future<void> onSendImage(BuildContext context) {
    return _$onSendImageAsyncAction.run(() => super.onSendImage(context));
  }

  @override
  String toString() {
    return '''
isImageUploading: ${isImageUploading},
isTyping: ${isTyping}
    ''';
  }
}
