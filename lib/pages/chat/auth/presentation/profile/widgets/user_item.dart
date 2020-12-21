import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';
import 'profile_avatar.dart';

class UserItemWidget extends StatelessWidget {
  final String userId;
  final String subtitle;
  final Widget trailing;

  const UserItemWidget(
      {Key key, @required this.userId, this.subtitle, this.trailing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userController = Modular.get<AuthController>();
    final isMe = userController.currentUser.id == userId;
    return FutureBuilder<User>(
        future: userController.userRepo.fetchUserData(userId),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) return Container();
          return SizedBox(
            width: 300,
            child: ListTile(
              leading: ProfileAvatarWidget(
                photoUrl: user?.photoUrl,
                showBadge: user?.isOnline,
                radius: 50,
              ),
              title: Text(
                isMe ? 'Me ' : '${user.name ?? ''}',
              ),
              subtitle: Text(
                subtitle ?? user.status ?? '',
              ),
              onTap: isMe
                  ? null
                  : () {
                      AuthModule.toOtherUserProfile(user.id);
                    },
            ),
          );
        });
  }
}
