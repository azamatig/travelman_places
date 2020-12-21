import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timeago/timeago.dart' as time_ago;
import '../../../../export.dart';
import '../../widgets/user_avatar.dart';

class UserPostWidget extends StatelessWidget {
  final Post post;
  final bool galleryView;

  const UserPostWidget({
    Key key,
    @required this.post,
    this.galleryView = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentUser = Modular.get<AuthController>().currentUser;
    final isMyPost = currentUser.id == post.authorId;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: isMyPost
            ? null
            : () {
                AuthModule.toOtherUserProfile(post.authorId);
              },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAvatar(
              photo: post.authorPhotoUrl,
              showBadge: false,
              radius: galleryView ? 30 : 45,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isMyPost ? 'Me ' : '${post.authorName ?? ''}',
                    maxLines: 1,
                  ),
                  Text(
                    time_ago.format(post.publishDate, locale: 'en_short'),
                  ),
                ],
              ),
            ),
            if (!galleryView)
              PopupMenuButton<int>(
                itemBuilder: (_) => [
                  if (!isMyPost) PopupMenuItem(value: 0, child: Text('Report')),
                  if (isMyPost || currentUser.isAdmin)
                    PopupMenuItem(value: 1, child: Text(t.Feed.edit)),
                ],
                onSelected: (v) {
                  if (v == 0) {
                    FeedsModule.toReportPost(post);
                  } else {
                    FeedsModule.toEditPost(post);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
