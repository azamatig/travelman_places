import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:uic/list_uic.dart';

import '../../export.dart';
import '../widgets/group_item.dart';
import 'controller.dart';

class GroupsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> with RouteAware {
  final RouteObserver routeObserver = Modular.get<AppStore>().routeObserver;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.groupListController.refresh();
  }

  final controller = Modular.get<GroupsController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Группы',
                  style: GoogleFonts.basic(
                      textStyle: theme.textTheme.headline5,
                      color: Colors.white),
                ).padding(top: 4, bottom: 8, left: 20),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: GroupsModule.toSearch,
                ),
              ],
            ),
            Expanded(
              child: ListUic<Group>(
                controller: controller.groupListController,
                itemBuilder: (group) => GroupItem(group: group),
                emptyProgressView: SpinKitCircle(color: Colors.green),
                emptyDataView: Center(
                  child: GestureDetector(
                    onTap: GroupsModule.toSearch,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(width: 22),
                        Text(t.Groups.join)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: GroupsModule.toCreateGroup,
              label: Text(
                t.Groups.create_group,
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.yellowAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
