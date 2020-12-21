import 'package:flutter/material.dart';
import '../../../export.dart';
import 'user_avatar.dart';

class UserCardWidget extends StatelessWidget {
  final User user;

  const UserCardWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => ChatModule.toConversation(user.id),
            child: UserAvatar(photo: user.photoUrl),
          ),
          SizedBox(height: 4),
          Text(
            '${user.name}',
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
