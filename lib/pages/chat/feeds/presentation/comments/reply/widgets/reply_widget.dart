import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:timeago/timeago.dart';

import '../../../../export.dart';
import '../../reply/controller.dart';
import '../../widgets/input.dart';

class ReplyWidget extends StatefulWidget {
  final Comment comment;
  final String commentParentId;

  const ReplyWidget({Key key, this.comment, this.commentParentId})
      : super(key: key);
  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  User get currentUser => Modular.get<AuthController>().currentUser;

  bool get isMyComment => currentUser.id == widget.comment.authorId;

  bool get likeIt => widget.comment.usersLikeIds.contains(currentUser.id);

  final controller = Modular.get<ReplyController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: UserAvatar(
        photo: widget.comment.authorPhotoUrl,
        showBadge: false,
        radius: 40,
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    '${isMyComment ? 'Me' : widget.comment.authorName ?? ''}: ',
                style: theme.textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
                text: widget.comment.content, style: theme.textTheme.subtitle1),
          ],
        ),
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
    );
  }

  void navigatorToReply() {
    Modular.to.navigator.push(
      MaterialPageRoute(
        builder: (_) => ReplyScreen(
          widget.comment.postId,
          widget.comment.id,
        ),
      ),
    );
  }

  void showCommentOptions(BuildContext context, TapDownDetails tap) {
    PopupMenu(
      context: context,
      lineColor: Colors.white,
      items: [
        // MenuItem(title: 'Edit', image: Icon(Icons.edit, color: Colors.white)),
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
                  // controller.edit(widget.comment);
                  Navigator.pop(context);
                },
              ),
            ).show();
            break;
          case 'Delete':
            AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                body: Text(t.Feed.comment_remove_confirm),
                btnCancelOnPress: () => null,
                btnOkOnPress: () {
                  controller.removeReplyComment(
                      widget.commentParentId, widget.comment);
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
