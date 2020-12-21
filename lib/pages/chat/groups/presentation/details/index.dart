import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../export.dart';
import '../widgets/group_avatar.dart';
import 'controller.dart';

class GroupDetails extends WidgetModule {
  final Group group;
  GroupDetails(this.group);

  @override
  List<Bind> get binds => [Bind((_) => DetailsController(group))];

  @override
  Widget get view => _GroupDetails();
}

class _GroupDetails extends StatefulWidget {
  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState
    extends ModularState<_GroupDetails, DetailsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) => Text(
            controller.group.name ?? '',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          if (controller.isAdmin)
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => GroupsModule.toGroupEditor(controller.group))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Observer(
                builder: (_) => GroupAvatar(
                  photoUrl: controller.group.photoUrl,
                  radius: 120,
                ),
              ),
              SizedBox(height: 20),
              Observer(
                builder: (_) => Text(
                  controller.group.name ?? '',
                  style: theme.textTheme.headline6,
                ),
              ),
              SizedBox(height: 20),
              //Members
              Observer(
                builder: (_) => ListTile(
                  title: Text(t.Groups.members),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('${controller.group.members.length}'),
                      SizedBox(width: 12),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                  onTap: GroupsModule.toGroupMembers,
                ),
              ),

              //Notifications
              if (controller.isMember)
                Observer(
                  builder: (_) => SwitchListTile.adaptive(
                    value: !controller.isMuted,
                    title: Text(t.Groups.notifications),
                    subtitle:
                        Text(controller.isMuted ? t.Groups.off : t.Groups.on),
                    onChanged: (v) => controller.muteOrUnmuteGroup(),
                  ),
                ),

              Spacer(flex: 4),
              if (!controller.isAdmin)
                Observer(
                  builder: (_) {
                    return controller.isMember
                        ? CustomButton(
                            t.Groups.leave,
                            onTap: () {
                              controller.joinOrLeaveGroup();
                              Navigator.of(context).popUntil((r) => r.isFirst);
                            },
                          )
                        : CustomButton(
                            t.Groups.join,
                            onTap: () {
                              controller.joinOrLeaveGroup();
                              Navigator.of(context).popUntil((r) => r.isFirst);
                              GroupsModule.toGroup(controller.group);
                            },
                          );
                  },
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
