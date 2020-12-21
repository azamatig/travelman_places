import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../../export.dart';
import 'chat_input/index.dart';

class ChatBubble extends StatelessWidget {
  final Message msg;

  ChatBubble({Key key, this.msg});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fromMe = Modular.get<ConversationCon>().isCurrentUser(msg.senderId);

    return Column(
      crossAxisAlignment:
          fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onLongPressEnd: !fromMe ? null : (p) => messageOptions(context, p),
          child: Bubble(
            margin: BubbleEdges.only(
              top: 10,
              left: fromMe ? 20 : 4,
              right: fromMe ? 4 : 20,
            ),
            nip: fromMe ? BubbleNip.rightTop : BubbleNip.leftTop,
            nipWidth: 2,
            alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
            color: fromMe ? Colors.grey : Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (msg.type == 0)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      msg.content,
                      style: GoogleFonts.basic(
                        textStyle: theme.textTheme.subtitle1,
                      ),
                    ),
                  ),
                if (msg.type == 1)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      child: Hero(
                        tag: msg.id,
                        child: msg.localPath == null
                            ? CachedNetworkImage(
                                imageUrl: msg.content,
                                placeholder: (_, __) =>
                                    CircularProgressIndicator(),
                                errorWidget: (_, __, ___) =>
                                    CircularProgressIndicator(),
                              )
                            : Image.file(File(msg.localPath)),
                      )..constrained(maxHeight: 300),
                      onTap: () {
                        msg.localPath == null
                            ? AppModule.showFullImage(msg.content)
                            : AppModule.showFullImage(msg.localPath,
                                isLocal: true);
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    DateFormat.Hm().format(msg.time.toLocal()),
                    style: TextStyle(fontSize: 8),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void messageOptions(BuildContext context, LongPressEndDetails press) {
    PopupMenu(
      context: context,
      lineColor: Colors.white,
      items: [
        if (msg.type == 0)
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
              body: ChatInput(
                onSend: Modular.to.pop,
                toEditMessage: msg,
              ),
            ).show();
            break;
          case 'Delete':
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              body: Text(t.Chat.msg_remove_confirm),
              btnCancelOnPress: () => null,
              btnOkOnPress: () {
                Modular.get<ConversationCon>().deleteMessage(msg);
              },
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
