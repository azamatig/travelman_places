import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';
import '../../widgets/group_avatar.dart';

class GroupAppBar extends StatelessWidget with PreferredSizeWidget {
  final controller = Modular.get<ConversationCon>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (controller.group == null) return Container();
    return Observer(
      builder: (_) => AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: GroupAvatar(
            photoUrl: controller.group.photoUrl ?? '',
            radius: 40,
          ),
          title: Text(
            controller.group.name ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            '${controller.group.members.length} ${t.Groups.members}',
            style: theme.textTheme.headline6.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          trailing: !controller.isMember ? null : Icon(Icons.info),
          onTap: !controller.isMember
              ? null
              : () => GroupsModule.toGroupDetails(controller.group),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
