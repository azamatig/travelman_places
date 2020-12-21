import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';
import 'presentation/details/index.dart';
import 'presentation/details/members.dart';
import 'presentation/groups_list/controller.dart';
import 'presentation/groups_list/widgets/search.dart';

class GroupsModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => GroupsRepoImp()),
        m.Bind((i) => GroupsController()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(
          GROUPS,
          child: (_, args) => GroupsWidget(),
        ),
        m.ModularRouter(
          CREATE,
          child: (_, args) => GroupEditor(),
        ),
        m.ModularRouter(
          SEARCH,
          child: (_, args) => GroupsSearch(),
        ),
      ];

  static const GROUPS = '/groups',
      CREATE = '/create_group',
      SEARCH = '/group_search';

  static Future toGroup(Group group) => _to(Conversation(group));
  static Future toCreateGroup() => m.Modular.to.pushNamed(CREATE);
  static Future toGroupDetails(Group group) => _to(GroupDetails(group));
  static Future toGroupMembers() => _to(MembersScreen());
  static Future toGroupEditor(Group group) =>
      _to(GroupEditor(toEditGroup: group));
  static Future toSearch() => m.Modular.to.pushNamed(SEARCH);

  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
