import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../export.dart';
import 'drawer_menu.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: theme.primaryColor,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerMenu(),
              Expanded(
                child: Observer(
                  builder: (_) => IndexedStack(
                    index: appStore.drawerState.index,
                    children: <Widget>[
                      GroupsWidget(),
                      NotificationScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
