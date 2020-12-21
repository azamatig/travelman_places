// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OtherUserProfileController on _OtherUserProfileController, Store {
  Computed<bool> _$isFollowingComputed;

  @override
  bool get isFollowing =>
      (_$isFollowingComputed ??= Computed<bool>(() => super.isFollowing,
              name: '_OtherUserProfileController.isFollowing'))
          .value;

  final _$otherUserAtom = Atom(name: '_OtherUserProfileController.otherUser');

  @override
  User get otherUser {
    _$otherUserAtom.reportRead();
    return super.otherUser;
  }

  @override
  set otherUser(User value) {
    _$otherUserAtom.reportWrite(value, super.otherUser, () {
      super.otherUser = value;
    });
  }

  @override
  String toString() {
    return '''
otherUser: ${otherUser},
isFollowing: ${isFollowing}
    ''';
  }
}
