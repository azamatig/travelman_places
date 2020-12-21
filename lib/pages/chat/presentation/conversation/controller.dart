import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../export.dart';

part 'controller.g.dart';

class ConversationCon = _ConversationCon
    with _$ConversationCon
    implements Disposable;

abstract class _ConversationCon with Store {
  final String userId;
  _ConversationCon(this.userId);
  final repo = Modular.get<ChatRepository>();
  final userRepo = Modular.get<UserRepository>();

  final scrollController =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  final refreshController = RefreshController(initialRefresh: false);

  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
  }

  User get currentUser => Modular.get<AuthController>().currentUser;

  @observable
  ObservableList<Message> msgs = <Message>[].asObservable();

  @observable
  int offset = 20;

  @action
  Future<void> onRefreshLoading() async {
    offset = msgs.length + 10;
    await Future.delayed(Duration(seconds: 2));
    refreshController.loadComplete();
  }

  Stream<User> get userStream =>
      Modular.get<AuthController>().userStream(userId);

  Stream<List<Message>> get conversationStream => repo.conversationStream(
      Message.getChatId(currentUser.id, userId), currentUser.id, offset);

  Future<void> deleteMessage(Message e) async {
    msgs.remove(e);
    await repo.deleteMessage(chatId: e.chatId, msgId: e.id);
  }

  Future<void> deleteConversation() async {
    await repo.removeConversation(
      Message.getChatId(currentUser.id, userId),
      currentUser.id,
    );
  }

  void readMsgs() {
    final unreadMsg = [
      for (final msg in msgs)
        if (!msg.read && msg.senderId == userId) msg.id
    ];
    if (unreadMsg.isNotEmpty) {
      repo.markReadMsgs(msgs.last.chatId, unreadMsg);
    }
  }

  bool isCurrentUser(String id) => currentUser.id == id;

  bool isBlocked(User user) => !user.blockedUsers.contains(currentUser.id);

  @action
  void mergeMsgs(List<Message> otherMsgs) {
    final currentMsgs = [...msgs];
    final msgsId = [for (final m in currentMsgs) m.id];
    for (var i = 0; i < otherMsgs.length; i++) {
      final msg = otherMsgs[i];
      if (!msgsId.contains(msg.id)) {
        currentMsgs.add(msg);
      }
    }

    msgs =
        (currentMsgs..sort((a, b) => b.time.compareTo(a.time))).asObservable();
  }

  void blockUser() async {
    if (currentUser.blockedUsers.contains(userId)) {
      currentUser.blockedUsers.remove(userId);
    } else {
      currentUser.blockedUsers.add(userId);
    }
    await userRepo.updateBlockedUsers(
        currentUser.id, currentUser.blockedUsers.toList());
  }
}
