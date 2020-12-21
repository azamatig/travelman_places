import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';

import '../../export.dart';
import '../chats/widgets/user_avatar.dart';
import 'controller.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input/index.dart';
import 'widgets/user_appbar.dart';

class Conversation extends WidgetModule {
  final String userId;
  Conversation(this.userId);

  @override
  List<Bind> get binds => [Bind((_) => ConversationCon(userId))];

  @override
  Widget get view => _Conversation();
}

class _Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends ModularState<_Conversation, ConversationCon> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<User>(
      stream: controller.userStream,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return Container();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            leading: BackButton(
              color: theme.iconTheme.color,
            ),
            title: UserAppBarTile(user: user),
            actions: <Widget>[
              PopupMenuButton<int>(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text(
                      controller.currentUser.blockedUsers.contains(user.id)
                          ? t.Chat.unblock
                          : t.Chat.block,
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(t.Chat.remove_conversation),
                  ),
                ],
                onSelected: (v) {
                  if (v == 0) {
                    controller.blockUser();
                  } else {
                    controller.deleteConversation();
                    Modular.to.pop();
                  }
                },
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Observer(
                    builder: (_) => StreamBuilder<List<Message>>(
                      stream: controller.conversationStream,
                      builder: (_, snapshot) {
                        controller.msgs =
                            ObservableList.of(snapshot.data ?? <Message>[]);
                        controller.readMsgs();
                        final myMsgs = [
                          for (final m in controller.msgs)
                            if (m.sendTo == controller.userId) m
                        ];
                        Message myLastUnreadMsg;
                        for (var i = 0; i < myMsgs.length; i++) {
                          final m = myMsgs[i];
                          if (!m.read) {
                            myLastUnreadMsg =
                                myMsgs[i == myMsgs.length - 1 ? i : i + 1];
                          }
                          myLastUnreadMsg ??= myMsgs.first;
                        }
                        return SmartRefresher(
                          controller: controller.refreshController,
                          enablePullUp:
                              controller.offset <= controller.msgs.length,
                          enablePullDown: false,
                          onLoading: controller.onRefreshLoading,
                          footer: CustomFooter(
                            loadStyle: LoadStyle.ShowAlways,
                            builder: (context, mode) {
                              if (mode == LoadStatus.loading) {
                                return Container(
                                  height: 60.0,
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    child: CupertinoActivityIndicator(),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          child: ListView.builder(
                            itemCount: controller.msgs.length,
                            reverse: true,
                            controller: controller.scrollController,
                            itemBuilder: (_, i) {
                              final maxIndex = controller.msgs.length - 1;
                              final msg = controller.msgs[i];
                              final msgAfter =
                                  controller.msgs[i == maxIndex ? i : i + 1];
                              return Column(
                                children: <Widget>[
                                  if (i == maxIndex ||
                                      msg.time.day != msgAfter.time.day)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(DateFormat.MMMMd()
                                          .format(msg.time.toLocal())),
                                    ),
                                  ChatBubble(msg: msg),
                                  if (myLastUnreadMsg?.id == msg.id)
                                    Align(
                                      alignment: Alignment(0.95, 0.2),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: UserAvatar(
                                          photo: user?.photoUrl,
                                          radius: 20,
                                          showBadge: false,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                controller.isBlocked(user)
                    ? ChatInput(onSend: () {})
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(t.Chat.cannot_chat_with_user),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
