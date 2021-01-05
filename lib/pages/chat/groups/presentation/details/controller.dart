import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';

import '../../export.dart';

part 'controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {
  final Group group;
  _DetailsControllerBase(this.group) {
    isMember = group.members.contains(currentUser.id);
    isMuted = group.mutedFor.contains(currentUser.id);
    membersListController = PagewiseLoadController<User>(
      pageFuture: (page) => repo.fetchMembers(group.id, page),
      pageSize: 20,
    );
  }
  final repo = Modular.get<GroupsRepository>();
  final userRepo = Modular.get<UserRepository>();
  PagewiseLoadController membersListController;
  @observable
  bool isMember;

  @observable
  bool isMuted;

  bool get isAdmin => group.admins.contains(currentUser.id);

  User get currentUser => Modular.get<AuthController>().currentUser;

  @action
  Future<void> joinOrLeaveGroup() async {
    try {
      isMember
          ? group.members.remove(currentUser.id)
          : group.members.add(currentUser.id);
      isMember = !isMember;
      await repo.joinOrLeaveGroup(
        groupId: group.id,
        userId: currentUser.id,
        isMember: !isMember,
      );
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> muteOrUnmuteGroup() async {
    try {
      isMuted
          ? group.mutedFor.remove(currentUser.id)
          : group.mutedFor.add(currentUser.id);
      isMuted = !isMuted;
      await repo.muteOrUnmuteGroup(
        groupId: group.id,
        userId: currentUser.id,
        isMuted: !isMuted,
      );
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> removeMember(String userId) async {
    try {
      group.members.remove(userId);
      await repo.joinOrLeaveGroup(
          groupId: group.id, userId: userId, isMember: true);
      membersListController.retry();
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> blockUnblockUser(String userId) async {
    final isBlocked = group.blockedUsers.contains(userId);
    try {
      isBlocked
          ? group.blockedUsers.remove(userId)
          : group.blockedUsers.add(userId);

      await repo.blockUnblockUser(
        groupId: group.id,
        userId: userId,
        isBlocked: isBlocked,
      );
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }
}
