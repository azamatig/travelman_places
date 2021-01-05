import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../../../export.dart';
import 'user_post_item.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final bool showMore;

  const PostWidget({Key key, @required this.post, this.showMore = true})
      : super(key: key);
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final controller = Modular.get<FeedController>();
  User get currentUser => controller.currentUser;

  bool get checkIfUserLikePost =>
      widget.post.usersLikes.contains(controller.currentUser.id);

  bool get isMyPost => currentUser.id == widget.post.authorId;

  @override
  Widget build(BuildContext context) {
    final postSentences = widget.post.content.split('\n');
    final theme = Theme.of(context);

    return Container(
      //  margin: const EdgeInsets.all(6),
      //  decoration: BoxDecoration(
      //     border: Border.all(color: theme.iconTheme.color, width: 0.5),
      //    borderRadius: BorderRadius.circular(5),
      //  ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserPostWidget(post: widget.post),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Observer(
              builder: (_) {
                if (widget.post.content.isEmpty) return SizedBox.shrink();
                final showMore = widget.showMore && postSentences.length > 5;
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: showMore
                            ? postSentences.take(5).join('\n')
                            : widget.post.content,
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
                              FeedsModule.toPost(widget.post.id);
                            },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (widget.post.hasImage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                child: CachedNetworkImage(
                        imageUrl: widget.post.imgUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorWidget: (context, _, __) => Icon(Icons.error))
                    .constrained(maxHeight: 500),
                onTap: () {
                  AppModule.showFullImage(widget.post.imgUrl);
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
                  onTap: () => controller.addOrRemoveReaction(widget.post),
                ),
                Container(
                  width: 0.5,
                  height: 20,
                  color: theme.iconTheme.color,
                ),
                SizedBox(width: 10),
                GestureDetector(
                  child: Text('${widget.post.usersLikes?.length ?? 0} Likes',
                      style: theme.textTheme.subtitle1),
                  onTap: () {
                    FeedsModule.toReactions(widget.post.usersLikes);
                  },
                ),
                Spacer(),
                FlatButton.icon(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  icon: Icon(Icons.mode_comment),
                  label: Text(
                    '${widget.post.commentsIds?.length ?? 0} Comments',
                    style: theme.textTheme.subtitle1,
                  ),
                  onPressed: () {
                    Modular.get<FeedController>().selectedPost = widget.post;
                    FeedsModule.toComments(
                        widget.post.id, widget.post.authorId);
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
