import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../export.dart';
import '../../widgets/group_avatar.dart';
import 'chat_input/index.dart';

class MessageItem extends StatefulWidget {
  final Message msg;
  MessageItem({Key key, this.msg}) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  final controller = Modular.get<ConversationCon>();
  String get userId => controller.currentUser.id;
  @override
  void initState() {
    super.initState();
    if (!widget.msg.seenBy.contains(userId)) {
      widget.msg.seenBy.add(userId);
      controller.repo.readMsg(
          groupId: controller.group.id, msgId: widget.msg.id, userId: userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fromMe = controller.currentUser.id == widget.msg.senderId;
    return Row(
      mainAxisAlignment:
          fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 8),
        if (!fromMe)
          GestureDetector(
            child: GroupAvatar(
              photoUrl: widget.msg.senderPicUrl,
              radius: 30,
            ),
            onTap: () => AuthModule.toOtherUserProfile(widget.msg.senderId),
          ),
        Flexible(
          child: Column(
            crossAxisAlignment:
                fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              if (!fromMe)
                Text(widget.msg.senderName, style: theme.textTheme.caption)
                    .padding(horizontal: 10),
              GestureDetector(
                onLongPressEnd: (press) =>
                    messageOptions(context, press, fromMe),
                child: Bubble(
                  margin: BubbleEdges.only(
                    left: fromMe ? 20 : 2,
                    right: fromMe ? 2 : 20,
                  ),
                  nip: fromMe ? BubbleNip.rightTop : BubbleNip.leftTop,
                  nipWidth: 2,
                  alignment:
                      fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  color: fromMe ? Colors.grey : Colors.blueGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      widget.msg.type == 0
                          ? Text(
                              widget.msg.content,
                              style: GoogleFonts.basic(
                                  textStyle: theme.textTheme.subtitle1),
                            )
                          : GestureDetector(
                              child: Hero(
                                tag: widget.msg.id,
                                child: widget.msg.localPath == null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.msg.content,
                                        placeholder: (_, __) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (_, __, ___) =>
                                            CircularProgressIndicator(),
                                      )
                                    : Image.file(File(widget.msg.localPath)),
                              )..constrained(maxHeight: 300),
                              onTap: () => widget.msg.localPath == null
                                  ? AppModule.showFullImage(widget.msg.content)
                                  : AppModule.showFullImage(
                                      widget.msg.localPath,
                                      isLocal: true),
                            ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat.Hm().format(widget.msg.time.toLocal()),
                        style: TextStyle(fontSize: 8),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ).padding(all: 4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void messageOptions(
      BuildContext context, LongPressEndDetails press, bool fromMe) {
    PopupMenu(
      context: context,
      lineColor: Colors.white,
      items: [
        if (fromMe && widget.msg.type == 0)
          MenuItem(title: 'Edit', image: Icon(Icons.edit, color: Colors.white)),
        if (fromMe || controller.currentUser.isAdmin)
          MenuItem(
              title: 'Delete', image: Icon(Icons.delete, color: Colors.white)),
        // if (!fromMe)
        //   MenuItem(
        //       title: 'Reply', image: Icon(Icons.replay, color: Colors.white)),
        if (!fromMe && controller.isAdmin)
          MenuItem(
              title: 'Block this user',
              image: Icon(Icons.block, color: Colors.white))
      ],
      onClickMenu: (m) {
        switch (m.menuTitle) {
          case 'Edit':
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              body: ChatInput(
                toEditMessage: widget.msg,
                onSend: Navigator.of(context).pop,
              ),
            ).show();
            break;
          case 'Delete':
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              body: Text('Are you sure you want to delete the message?'),
              btnCancelOnPress: () => null,
              btnOkOnPress: () =>
                  controller.deleteMessage(msgId: widget.msg.id),
            ).show();
            break;
          default:
        }
      },
    )..show(
        rect: Rect.fromCenter(
            center: press.globalPosition, width: 40, height: 40));
  }
}
