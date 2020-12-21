import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../export.dart';
import '../../widgets/profile_avatar.dart';
import '../controller.dart';

class OProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final OtherUserProfileController controller;

  const OProfileHeader({Key key, @required this.controller}) : super(key: key);
  User get user => controller.otherUser;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 170,
          left: 0,
          right: 0,
          child: SizedBox(height: 200)
              .decorated(gradient: AppTheme.primaryGradient),
        ),
        Positioned(
          bottom: 120,
          left: 1,
          right: 1,
          child: Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              color: theme.scaffoldBackgroundColor,
              child: Observer(
                builder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      user.name ?? '',
                      style: GoogleFonts.basic().copyWith(fontSize: 28),
                      maxLines: 1,
                    ),
                    Text(user.status ?? ''),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ).width(MediaQuery.of(context).size.width * 4 / 5),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 250,
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(),
            elevation: 0,
            actions: [
              if (controller.currentUser.isSuperAdmin)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    child: Text(
                      user.isBanned ? 'UnBan' : 'Ban',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: controller.banUser,
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 190,
          child: Center(
            child: Material(
              elevation: 5.0,
              shape: CircleBorder(),
              child: Observer(
                builder: (_) => ProfileAvatarWidget(
                  photoUrl: user.photoUrl,
                  // isLoading: state is LoadingProfilePic,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 60,
          child: Center(
            child: Observer(
              builder: (_) {
                controller.currentUser.following;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: controller.isFollowing
                          ? Colors.black
                          : theme.primaryColor,
                      onPressed: () => controller.followUser(user.id),
                      child: Text(
                        controller.isFollowing
                            ? t.Auth.following
                            : t.Auth.follow,
                        style: GoogleFonts.alike().copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ).width(70),
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      color: theme.primaryColor,
                      onPressed: () => ChatModule.toConversation(user.id),
                      child: Text(
                        t.Auth.message,
                        style: GoogleFonts.alike().copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ).width(70),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ).height(350).backgroundColor(theme.scaffoldBackgroundColor);
  }

  @override
  Size get preferredSize => Size.fromHeight(350);
}
