// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatController, Store {
  Computed<int> _$unreadMsgCountComputed;

  @override
  int get unreadMsgCount =>
      (_$unreadMsgCountComputed ??= Computed<int>(() => super.unreadMsgCount,
              name: '_ChatController.unreadMsgCount'))
          .value;

  final _$_ChatControllerActionController =
      ActionController(name: '_ChatController');

  @override
  void removeFromUnreadMsg(String id) {
    final _$actionInfo = _$_ChatControllerActionController.startAction(
        name: '_ChatController.removeFromUnreadMsg');
    try {
      return super.removeFromUnreadMsg(id);
    } finally {
      _$_ChatControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToUnreadRead(String id) {
    final _$actionInfo = _$_ChatControllerActionController.startAction(
        name: '_ChatController.addToUnreadRead');
    try {
      return super.addToUnreadRead(id);
    } finally {
      _$_ChatControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
unreadMsgCount: ${unreadMsgCount}
    ''';
  }
}
