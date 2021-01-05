import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../export.dart';
import 'widget/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState
    extends ModularState<NotificationScreen, NotificationController> {
  int offset = 20;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            t.Notifications.title,
            style: GoogleFonts.basic(
                textStyle: theme.textTheme.headline6, color: Colors.white),
          ),
          trailing: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: StreamBuilder<List<OtakuNotification>>(
            stream: controller.notificationsStream(offset),
            builder: (context, snapshot) {
              final nots = snapshot.data ?? [];
              if (nots.isEmpty) return Container();
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: false,
                enablePullUp: offset <= nots.length,
                onLoading: () async {
                  setState(() {
                    offset = nots.length + 20;
                  });
                  await Future.delayed(Duration(seconds: 2));
                  controller.refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: nots.length,
                  itemBuilder: (_, i) => NotificationItem(
                    notification: nots[i],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
