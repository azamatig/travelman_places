import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../export.dart';
import '../controller.dart';

class MemberItem extends StatelessWidget {
  final User user;
  MemberItem({Key key, this.user}) : super(key: key);
  final controller = Modular.get<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Container()
        : ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl ?? ''),
            ),
            title: Row(
              children: <Widget>[
                Text(user.name ?? ''),
                Spacer(),
                if (controller.group.isAdmin(user.id))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.yellow),
                    ),
                    child: Text(t.Groups.admin),
                  )
              ],
            ),
            trailing: !controller.isAdmin
                ? null
                : Observer(
                    builder: (_) {
                      final isBlocked = controller.group.isBlocked(user.id);
                      return PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: 0,
                            child: Text(
                              isBlocked ? t.Groups.unblock : t.Groups.block,
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text(t.Groups.remove_member),
                          ),
                        ],
                        onSelected: (v) {
                          if (v == 0) {
                            controller.blockUnblockUser(user.id);
                          } else if (v == 1) {
                            controller.removeMember(user.id);
                          }
                        },
                      );
                    },
                  ),
          );
  }
}
