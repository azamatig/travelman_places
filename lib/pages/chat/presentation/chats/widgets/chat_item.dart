import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timeago/timeago.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../../export.dart';
import 'user_avatar.dart';

class ChatItem extends StatefulWidget {
  final Chat chat;

  ChatItem({Key key, this.chat}) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final controller = Modular.get<ChatController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: Modular.get<AuthController>()
          .userStream(controller.getSenderId(widget.chat)),
      builder: (_, userSnapshot) {
        final user = userSnapshot.data;
        return user == null
            ? Container()
            : StreamBuilder<List<Message>>(
                stream: controller.conversationStream(user.id),
                builder: (context, convSnapshot) {
                  final msgs = convSnapshot.data ?? [];
                  if (msgs.isEmpty) return Container();
                  final unreadMsgs = [
                    for (final m in msgs)
                      if (!m.read && controller.isCurrentUser(m.sendTo)) m.id
                  ];
                  final lastMsg = msgs.first;
                  return ListTile(
                    leading: Hero(
                      tag: 'chat-${user.id}',
                      child: UserAvatar(
                        photo: user.photoUrl,
                        radius: 50,
                        showBadge: false,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      lastMsg.type == 0
                          ? lastMsg.content
                          : lastMsg.type == 1
                              ? '🏙 ${t.Chat.img_msg}'
                              : '🔈 ${t.Chat.voice_msg}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Badge(
                            showBadge: unreadMsgs.isNotEmpty,
                            badgeContent: Text(
                              unreadMsgs.length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            format(widget.chat.updateTime, locale: 'en_short'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => ChatModule.toConversation(user.id),
                  );
                },
              );
      },
    );
  }
}
