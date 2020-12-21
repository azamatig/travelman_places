import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../export.dart';

class MenuItem extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String title;
  final Function action;
  final bool updateIndicatorVisible;
  final DrawerState drawerState;

  const MenuItem({
    Key key,
    this.icon,
    this.action,
    this.drawerState,
    this.color = Colors.white,
    this.updateIndicatorVisible = false,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appStore = Modular.get<AppStore>();

    return Observer(builder: (_) {
      final isSelected = appStore.drawerState == drawerState;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: isSelected ? 11 : 15),
                child: !isSelected
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Container(
                          width: 4,
                          height: 44,
                          color: color,
                        ),
                      ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(
                      Radius.circular(isSelected ? 8.0 : 22.0)),
                ),
                child: IconButton(
                  icon: Badge(showBadge: updateIndicatorVisible, child: icon),
                  onPressed: isSelected ? null : action,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                title,
                maxLines: 1,
                minFontSize: 10,
              ),
            ),
        ],
      );
    });
  }
}
