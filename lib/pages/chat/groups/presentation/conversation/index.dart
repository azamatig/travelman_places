import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../export.dart';
import 'controller.dart';
import 'widgets/chat_input/index.dart';
import 'widgets/group_appbar.dart';
import 'widgets/message_item.dart';

class Conversation extends WidgetModule {
  final Group group;
  Conversation(this.group);

  @override
  List<Bind> get binds => [Bind((_) => ConversationCon(group))];

  @override
  Widget get view => _Conversation();
}

class _Conversation extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends ModularState<_Conversation, ConversationCon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroupAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Observer(
                builder: (_) => StreamBuilder<List<Message>>(
                  stream: controller.msgsStream,
                  builder: (_, snapshot) {
                    controller.msgs = ObservableList.of(snapshot.data ?? []);
                    return SmartRefresher(
                      controller: controller.refreshController,
                      enablePullUp:
                          controller.msgsOffset <= controller.msgs.length,
                      enablePullDown: false,
                      onLoading: controller.onRefreshLoading,
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
                                Text(DateFormat.MMMMd()
                                        .format(msg.time.toLocal()))
                                    .padding(vertical: 8),
                              MessageItem(msg: msg),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Observer(
              builder: (_) => controller.isMember
                  ? ChatInput(
                      onSend: () {
                        controller.scrollController.animateTo(0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        child: Text(t.Groups.join),
                        onPressed: controller.joinOrLeaveGroup,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
