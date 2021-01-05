import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import 'package:uic/list_uic.dart';

import '../../export.dart';
import 'widgets/chat_item.dart';
import 'widgets/user_card.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with RouteAware {
  final controller = Modular.get<ChatController>();
  final RouteObserver routeObserver = Modular.get<AppStore>().routeObserver;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.chatList.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.Chat.title,
          style: GoogleFonts.abrilFatface(
              textStyle: theme.textTheme.headline6
                  .copyWith(fontSize: 24, color: Colors.white)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Online Users
              Text(
                t.Chat.online_users,
                style: theme.textTheme.headline6.copyWith(
                  color: Colors.grey,
                ),
              ).padding(all: 12),
              SizedBox(
                height: 100.0,
                child: StreamBuilder<List<User>>(
                  stream: controller.onlineUsers,
                  builder: (_, snapshot) {
                    final users = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: users.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        final user = users[index];
                        return controller.isCurrentUser(user.id)
                            ? SizedBox.shrink()
                            : UserCardWidget(user: user);
                      },
                    );
                  },
                ),
              ),
              //Chats
              Text(
                t.Chat.recent_chats,
                style: theme.textTheme.headline6,
              ).textColor(Colors.grey).padding(all: 12),
              ListUic<Chat>(
                controller: controller.chatList,
                itemBuilder: (chat) => ChatItem(chat: chat),
                nextPageProgressView: SpinKitCircle(color: Colors.green),
                emptyProgressView: SpinKitCircle(color: Colors.green),
                emptyDataView: SizedBox(),
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
