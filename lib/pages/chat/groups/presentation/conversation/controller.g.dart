// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConversationCon on _ConversationCon, Store {
  Computed<bool> _$isAdminComputed;

  @override
  bool get isAdmin => (_$isAdminComputed ??=
          Computed<bool>(() => super.isAdmin, name: '_ConversationCon.isAdmin'))
      .value;

  final _$msgsOffsetAtom = Atom(name: '_ConversationCon.msgsOffset');

  @override
  int get msgsOffset {
    _$msgsOffsetAtom.reportRead();
    return super.msgsOffset;
  }

  @override
  set msgsOffset(int value) {
    _$msgsOffsetAtom.reportWrite(value, super.msgsOffset, () {
      super.msgsOffset = value;
    });
  }

  final _$isMemberAtom = Atom(name: '_ConversationCon.isMember');

  @override
  bool get isMember {
    _$isMemberAtom.reportRead();
    return super.isMember;
  }

  @override
  set isMember(bool value) {
    _$isMemberAtom.reportWrite(value, super.isMember, () {
      super.isMember = value;
    });
  }

  final _$isMutedAtom = Atom(name: '_ConversationCon.isMuted');

  @override
  bool get isMuted {
    _$isMutedAtom.reportRead();
    return super.isMuted;
  }

  @override
  set isMuted(bool value) {
    _$isMutedAtom.reportWrite(value, super.isMuted, () {
      super.isMuted = value;
    });
  }

  final _$onRefreshLoadingAsyncAction =
      AsyncAction('_ConversationCon.onRefreshLoading');

  @override
  Future<void> onRefreshLoading() {
    return _$onRefreshLoadingAsyncAction.run(() => super.onRefreshLoading());
  }

  final _$joinOrLeaveGroupAsyncAction =
      AsyncAction('_ConversationCon.joinOrLeaveGroup');

  @override
  Future<void> joinOrLeaveGroup() {
    return _$joinOrLeaveGroupAsyncAction.run(() => super.joinOrLeaveGroup());
  }

  final _$muteOrUnmuteGroupAsyncAction =
      AsyncAction('_ConversationCon.muteOrUnmuteGroup');

  @override
  Future<void> muteOrUnmuteGroup() {
    return _$muteOrUnmuteGroupAsyncAction.run(() => super.muteOrUnmuteGroup());
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
msgsOffset: ${msgsOffset},
isMember: ${isMember},
isMuted: ${isMuted},
isAdmin: ${isAdmin}
    ''';
  }
}
