import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../../../export.dart';
import '../../widgets/profile_avatar.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  User get user => Modular.get<AuthController>().currentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: SizedBox(height: 200)
              .decorated(gradient: AppTheme.primaryGradient),
        ),
        Positioned(
          bottom: 60,
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
          bottom: 200,
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(),
            elevation: 0,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 130,
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
      ],
    ).height(300).backgroundColor(theme.scaffoldBackgroundColor);
  }

  @override
  Size get preferredSize => Size.fromHeight(300);
}
