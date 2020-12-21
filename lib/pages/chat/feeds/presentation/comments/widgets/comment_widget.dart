import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:timeago/timeago.dart';

import '../../../export.dart';
import '../controller.dart';
import 'input.dart';
import 'replies_widget.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;

  const CommentWidget({Key key, this.comment}) : super(key: key);
  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  User get currentUser => Modular.get<AuthController>().currentUser;

  bool get isMyComment => currentUser.id == widget.comment.authorId;

  bool get likeIt => widget.comment.usersLikeIds.contains(currentUser.id);

  final controller = Modular.get<CommentsController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: UserAvatar(
            photo: widget.comment.authorPhotoUrl,
            showBadge: false,
            radius: 40,
          ),
          title: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text:
                      '${isMyComment ? 'Me' : widget.comment.authorName ?? ''}: ',
                  style: theme.textTheme.subtitle1
                      .copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: widget.comment.content,
                  style: theme.textTheme.subtitle1),
            ]),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Observer(
              builder: (_) => Row(
                children: <Widget>[
                  Text(format(widget.comment.publishDate, locale: 'en_short')),
                  SizedBox(width: 20),
                  Text(
                    widget.comment.usersLikeIds.isEmpty
                        ? ''
                        : '${widget.comment.usersLikeIds.length} ${t.Feed.likes}',
                  ),
                  Container(
                    width: 1,
                    height: 10,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  GestureDetector(
                    child: Icon(
                      likeIt ? Icons.favorite : Icons.favorite_border,
                    ),
                    onTap: () {
                      controller.addOrRemoveReaction(widget.comment);
                    },
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    child: Text(
                      t.Feed.reply,
                      style: theme.textTheme.button,
                    ),
                    onTap: () => FeedsModule.toReply(
                      widget.comment.postId,
                      widget.comment.id,
                    ),
                  ),
                ],
              ),
            ),
          ),
          trailing: isMyComment || controller.currentUser.isAdmin
              ? GestureDetector(
                  child: Icon(Icons.more_vert),
                  onTapDown: (tap) => showCommentOptions(context, tap),
                )
              : null,
          onTap: isMyComment || widget.comment.authorId == null
              ? null
              : () {
                  AuthModule.toOtherUserProfile(widget.comment.authorId);
                },
        ),
        GestureDetector(
          onTap: () => FeedsModule.toReply(
            widget.comment.postId,
            widget.comment.id,
          ),
          child: RepliesWidget(
            replies: widget.comment.replyComments,
          ),
        )
      ],
    );
  }

  void showCommentOptions(BuildContext context, TapDownDetails tap) {
    PopupMenu(
      context: context,
      lineColor: Colors.white,
      items: [
        MenuItem(title: 'Edit', image: Icon(Icons.edit, color: Colors.white)),
        MenuItem(
            title: 'Delete', image: Icon(Icons.delete, color: Colors.white)),
      ],
      onClickMenu: (m) {
        switch (m.menuTitle) {
          case 'Edit':
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              body: CommentInput(
                showAvatar: false,
                initContent: widget.comment.content,
                onSubmit: (c) {
                  widget.comment.content = c;
                  controller.editComment(widget.comment);
                  Navigator.pop(context);
                },
              ),
            ).show();
            break;
          case 'Delete':
            AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                body: Text(t.Feed.not_allowed_comment),
                btnCancelOnPress: () => null,
                btnOkOnPress: () {
                  controller.deleteComment(widget.comment.id);
                }).show();

            break;
          default:
        }
      },
    )..show(
        rect: Rect.fromCenter(
          center: tap.globalPosition,
          width: 40,
          height: 40,
        ),
      );
  }
}
