import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';

import '../../../export.dart';
import '../../chats/widgets/user_avatar.dart';

class UserAppBarTile extends StatelessWidget {
  final User user;

  const UserAppBarTile({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Hero(
        tag: user.id,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Theme(
            data: ThemeData.dark(),
            child: UserAvatar(
              photo: user.photoUrl,
              radius: 45,
              showBadge: false,
            ),
          ),
        ),
      ),
      title: Text(
        user.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: user.lastTimeSeen == null && user.isOnline == false
          ? null
          : Text(
              user.isOnline == true
                  ? t.Chat.online
                  : user.onlineStatus
                      ? format(user.lastTimeSeen, locale: 'en_short')
                      : '',
              style: theme.textTheme.headline6.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
            ),
      onTap: () => AuthModule.toOtherUserProfile(user.id),
    );
  }
}
