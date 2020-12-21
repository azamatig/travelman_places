import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String photoUrl;
  final double radius;
  final bool editable;
  final bool isLoading;
  final bool showBadge;
  final File photoFile;
  final VoidCallback onTap;

  const ProfileAvatarWidget({
    Key key,
    @required this.photoUrl,
    this.radius,
    this.editable = false,
    this.isLoading = false,
    this.showBadge = false,
    this.photoFile,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Badge(
          showBadge: showBadge ?? false,
          badgeColor: Colors.green,
          badgeContent: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 1.5,
          ),
          position: BadgePosition(
            bottom: 1,
            end: 1,
          ),
          child: ClipOval(
            child: Container(
              color: Theme.of(context).primaryColor,
              width: radius ?? 100,
              height: radius ?? 100,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : photoFile == null
                      ? CachedNetworkImage(
                          imageUrl: photoUrl ?? '',
                          errorWidget: (_, __, ___) => Icon(
                            Icons.person,
                            size: (radius ?? 80) - 20,
                            color: Colors.white,
                          ),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          photoFile,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
        if (editable)
          Positioned(
            bottom: 2,
            right: 2,
            child: CircleAvatar(
              radius: 15,
              child: GestureDetector(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
                onTap: onTap ?? Modular.get<UserController>().changeProfilePic,
              ),
            ),
          ),
      ],
    );
  }
}
