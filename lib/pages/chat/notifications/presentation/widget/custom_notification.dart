import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNotificationWidget extends StatelessWidget {
  final String senderName, message;
  final void Function(BuildContext) onTap;

  const CustomNotificationWidget(
      {Key key, this.senderName, this.message, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidCommentAlt,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text(
                  senderName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.acme(
                      textStyle: theme.textTheme.subtitle1
                          .copyWith(color: Colors.white)),
                  // style: AppTheme.notificationTitle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                message?.startsWith('https://') == true
                    ? '🏙 Image'
                    : message ?? '',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.basic(
                    textStyle:
                        theme.textTheme.subtitle1.copyWith(color: Colors.white)),

                // style: AppTheme.notificationBody,
              ),
            )
          ],
        ),
      ),
    );
  }
}
