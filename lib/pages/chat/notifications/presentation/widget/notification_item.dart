import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../export.dart';

class NotificationItem extends StatelessWidget {
  final OtakuNotification notification;
  final void Function(BuildContext) onTap;

  NotificationItem({Key key, @required this.notification, this.onTap})
      : super(key: key);

  final controller = Modular.get<NotificationController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 6, right: 8, left: 8),
      child: Material(
        color: theme.brightness == Brightness.dark
            ? theme.primaryColorDark.withAlpha(80)
            : theme.primaryColorLight.withAlpha(100),
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () => controller.onNotificationTap(context, notification),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                icon,
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    notification?.content() ?? '',
                    style:
                        GoogleFonts.basic(textStyle: theme.textTheme.subtitle1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get icon {
    switch (notification.runtimeType) {
      case FollowNotification:
        return Icon(FontAwesomeIcons.userPlus);
      case PostReactionNotification:
        return Icon(Icons.favorite);
      case PostCommentNotification:
        return Icon(FontAwesomeIcons.comment);
      default:
        return Icon(FontAwesomeIcons.heart);
    }
  }
}
