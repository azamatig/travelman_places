import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String photo;
  final double radius;
  final bool showBadge;

  const UserAvatar({Key key, this.photo, this.radius, this.showBadge = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: showBadge,
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
        child: CachedNetworkImage(
          imageUrl: photo ?? '',
          errorWidget: (_, __, ___) => Container(
            width: radius ?? 70,
            height: radius ?? 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(Icons.person,
                size: radius == null
                    ? 35
                    : (radius > 40 ? radius - 20 : radius - 10),
                color: Colors.white),
          ),
          fit: BoxFit.cover,
          width: radius ?? 70,
          height: radius ?? 70,
        ),
      ),
    );
  }
}
