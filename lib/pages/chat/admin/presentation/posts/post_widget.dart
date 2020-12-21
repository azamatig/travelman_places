import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'package:travelman/pages/chat/i18n/strings.g.dart';

import '../../export.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final bool showMore;

  PostWidget({Key key, @required this.post, this.showMore = true})
      : super(key: key);

  final repo = Modular.get<AdminRepo>();

  final controller = Modular.get<FeedController>();
  User get currentUser => controller.currentUser;

  bool get checkIfUserLikePost =>
      post.usersLikes.contains(controller.currentUser.id);

  bool get isMyPost => currentUser.id == post.authorId;

  @override
  Widget build(BuildContext context) {
    final postSentences = post.content.split('\n');
    final theme = Theme.of(context);
    final isMyPost = currentUser.id == post.authorId;

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: theme.iconTheme.color, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
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
                    radius: 45,
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
                  PopupMenuButton<int>(
                    itemBuilder: (_) => [
                      if (!isMyPost)
                        PopupMenuItem(value: 0, child: Text('UnReport')),
                      if (isMyPost || currentUser.isAdmin)
                        if (isMyPost || currentUser.isAdmin)
                          PopupMenuItem(
                            value: 1,
                            child: Text(t.Feed.delete),
                          ),
                    ],
                    onSelected: (v) {
                      if (v == 0) {
                        repo.unReportPost(post.id);
                      } else {
                        controller.repo.removePost(
                            post.id, post.authorId, post.commentsIds);
                        repo.unReportPost(post.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Observer(
              builder: (_) {
                if (post.content.isEmpty) return SizedBox.shrink();
                final showMore = postSentences.length > 5;
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: showMore
                            ? postSentences.take(5).join('\n')
                            : post.content,
                        style: theme.textTheme.bodyText2,
                      ),
                      if (showMore)
                        TextSpan(
                          text: '\n${t.Feed.read_more}\n',
                          style: theme.textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.accentColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              FeedsModule.toPost(post.id);
                            },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (post.hasImage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: GestureDetector(
                child: CachedNetworkImage(
                        imageUrl: post.imgUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorWidget: (context, _, __) => Icon(Icons.error))
                    .constrained(maxHeight: 500),
                onTap: () {
                  AppModule.showFullImage(post.imgUrl);
                },
              ),
            ),
          Observer(
            builder: (_) => Row(
              children: <Widget>[
                SizedBox(width: 10),
                GestureDetector(
                  child: Icon(
                    checkIfUserLikePost
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ).padding(left: 6, right: 12),
                  onTap: () => controller.addOrRemoveReaction(post),
                ),
                Container(
                  width: 0.5,
                  height: 20,
                  color: theme.iconTheme.color,
                ),
                SizedBox(width: 10),
                GestureDetector(
                  child: Text('${post.usersLikes?.length ?? 0} Likes',
                      style: theme.textTheme.subtitle1),
                  onTap: () {
                    FeedsModule.toReactions(post.usersLikes);
                  },
                ),
                Spacer(),
                FlatButton.icon(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  icon: Icon(Icons.mode_comment),
                  label: Text(
                    '${post.commentsIds?.length ?? 0} Comments',
                    style: theme.textTheme.subtitle1,
                  ),
                  onPressed: () {
                    Modular.get<FeedController>().selectedPost = post;
                    FeedsModule.toComments(post.id, post.authorId);
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
