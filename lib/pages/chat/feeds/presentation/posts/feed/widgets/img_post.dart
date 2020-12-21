import 'package:flutter/material.dart';
import '../../../../export.dart';
import 'user_post_item.dart';

class ImagePostWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const ImagePostWidget({Key key, @required this.post, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: theme.iconTheme.color, width: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: CustomNetworkImage(
                url: post.imgUrl ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              onTap: onTap,
            ),
          ),
          UserPostWidget(post: post, galleryView: true),
        ],
      ),
    );
  }
}
