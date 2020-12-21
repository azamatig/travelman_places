// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsController on _DetailsControllerBase, Store {
  final _$isMemberAtom = Atom(name: '_DetailsControllerBase.isMember');

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

  final _$isMutedAtom = Atom(name: '_DetailsControllerBase.isMuted');

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

  final _$joinOrLeaveGroupAsyncAction =
      AsyncAction('_DetailsControllerBase.joinOrLeaveGroup');

  @override
  Future<void> joinOrLeaveGroup() {
    return _$joinOrLeaveGroupAsyncAction.run(() => super.joinOrLeaveGroup());
  }

  final _$muteOrUnmuteGroupAsyncAction =
      AsyncAction('_DetailsControllerBase.muteOrUnmuteGroup');

  @override
  Future<void> muteOrUnmuteGroup() {
    return _$muteOrUnmuteGroupAsyncAction.run(() => super.muteOrUnmuteGroup());
  }

  final _$removeMemberAsyncAction =
      AsyncAction('_DetailsControllerBase.removeMember');

  @override
  Future<void> removeMember(String userId) {
    return _$removeMemberAsyncAction.run(() => super.removeMember(userId));
  }

  final _$blockUnblockUserAsyncAction =
      AsyncAction('_DetailsControllerBase.blockUnblockUser');

  @override
  Future<void> blockUnblockUser(String userId) {
    return _$blockUnblockUserAsyncAction
        .run(() => super.blockUnblockUser(userId));
  }

  @override
  String toString() {
    return '''
isMember: ${isMember},
isMuted: ${isMuted}
    ''';
  }
}
