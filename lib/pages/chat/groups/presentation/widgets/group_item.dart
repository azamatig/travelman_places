import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../export.dart';
import '../groups_list/controller.dart';
import 'group_avatar.dart';

class GroupItem extends StatelessWidget {
  final Group group;

  GroupItem({Key key, @required this.group}) : super(key: key);

  final controller = Modular.get<GroupsController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      leading: GroupAvatar(photoUrl: group.photoUrl, radius: 40),
      title: Text(
        group.name,
        style: GoogleFonts.basic(
            textStyle: Theme.of(context).textTheme.subtitle1,
            color: Colors.white),
      ),
      trailing: StreamBuilder<List<Message>>(
        stream: controller.repo.msgsStream(group.id, 10),
        builder: (_, snapshot) {
          final msgs = [
            for (final m in snapshot.data ?? <Message>[])
              if (!m.seenBy.contains(controller.currentUserId)) m
          ];
          return Badge(
            showBadge: msgs.isNotEmpty,
            badgeContent: Text(
              msgs.length > 9 ? '9+' : ' ${msgs.length} ',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      onTap: () async {
        Modular.get<NotificationController>()
            .updateUserLocation(UserNavigationTracker.groupChatting(group));

        await GroupsModule.toGroup(group);

        Modular.get<NotificationController>()
            .updateUserLocation(UserNavigationTracker.onFeed());
      },
    );
  }
}
