import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uic/list_uic.dart';

import '../../export.dart';

part 'controller.g.dart';

class GroupsController = _GroupsController with _$GroupsController;

abstract class _GroupsController with Store {
  final repo = Modular.get<GroupsRepository>();
  ListUicController<Group> groupListController;

  _GroupsController() {
    groupListController = ListUicController<Group>(
      onGetItems: (page) => repo.fetchMyGroups(currentUserId, page: page),
    );
  }

  String get currentUserId => Modular.get<AuthController>().currentUser.id;

  Stream<List<Message>> unseenMsgsStream(String groupId) =>
      repo.unseenMsgsStream(groupId, currentUserId);
}
