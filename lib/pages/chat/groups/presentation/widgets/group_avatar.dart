import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class GroupAvatar extends StatelessWidget {
  final String photoUrl;
  final double radius;

  const GroupAvatar({Key key, @required this.photoUrl, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: radius ?? 40,
      height: radius ?? 40,
      child: CachedNetworkImage(
        imageUrl: photoUrl ?? '',
        errorWidget: (_, __, ___) => Icon(
          Icons.group,
          color: Colors.white,
          size: (radius ?? 40) - 10,
        ),
        fit: BoxFit.fill,
      ),
    ).backgroundColor(theme.primaryColorDark).clipOval();
  }
}
