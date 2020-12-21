// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConversationCon on _ConversationCon, Store {
  final _$msgsAtom = Atom(name: '_ConversationCon.msgs');

  @override
  ObservableList<Message> get msgs {
    _$msgsAtom.reportRead();
    return super.msgs;
  }

  @override
  set msgs(ObservableList<Message> value) {
    _$msgsAtom.reportWrite(value, super.msgs, () {
      super.msgs = value;
    });
  }

  final _$offsetAtom = Atom(name: '_ConversationCon.offset');

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

  final _$onRefreshLoadingAsyncAction =
      AsyncAction('_ConversationCon.onRefreshLoading');

  @override
  Future<void> onRefreshLoading() {
    return _$onRefreshLoadingAsyncAction.run(() => super.onRefreshLoading());
  }

  final _$_ConversationConActionController =
      ActionController(name: '_ConversationCon');

  @override
  void mergeMsgs(List<Message> otherMsgs) {
    final _$actionInfo = _$_ConversationConActionController.startAction(
        name: '_ConversationCon.mergeMsgs');
    try {
      return super.mergeMsgs(otherMsgs);
    } finally {
      _$_ConversationConActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
msgs: ${msgs},
offset: ${offset}
    ''';
  }
}
