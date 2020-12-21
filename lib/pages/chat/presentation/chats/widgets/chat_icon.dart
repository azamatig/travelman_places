import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../export.dart';
import '../controller.dart';

class ChatIcon extends StatelessWidget {
  final controller = Modular.get<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
          child: GestureDetector(
            child: Badge(
              showBadge: (controller.unreadMsgCount ?? 0) > 0,
              position: BadgePosition.topEnd(end: -6, top: -2),
              badgeContent: Text(
                '${controller.unreadMsgCount}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: Icon(
                FontAwesomeIcons.facebookMessenger,
                size: 32,
              ),
            ),
            onTap: ChatModule.toChats,
          ),
        );
      },
    );
  }
}
