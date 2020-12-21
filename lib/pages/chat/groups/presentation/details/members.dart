import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import '../../export.dart';
import '../widgets/group_avatar.dart';
import 'controller.dart';
import 'widgets/member_item.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final controller = Modular.get<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: GroupAvatar(
                photoUrl: controller.group.photoUrl ?? '',
                radius: 40,
              ),
              title: Text(
                controller.group.name ?? '',
              ),
              subtitle: Text(
                '${controller.group.members.length} ${t.Groups.members}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            centerTitle: true,
          ),
          body: PagewiseListView<User>(
            pageLoadController: controller.membersListController,
            itemBuilder: (_, user, __) => Observer(
              builder: (_) => controller.currentUser.id == user.id ||
                      !controller.group.members.contains(user.id)
                  ? SizedBox.fromSize()
                  : MemberItem(user: user),
            ),
          ),
        );
      },
    );
  }
}
