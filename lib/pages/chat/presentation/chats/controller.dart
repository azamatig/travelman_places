import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uic/list_uic.dart';

import '../../export.dart';

part 'controller.g.dart';

const CHATS_UNREAD_MSGS_KEY = 'chats-unread-messages-key';

class ChatController = _ChatController with _$ChatController;

abstract class _ChatController with Store {
  final repo = Modular.get<ChatRepository>();
  final appStore = Modular.get<AppStore>();

  ListUicController<Chat> chatList;
  _ChatController() {
    chatList = ListUicController<Chat>(
      onGetItems: (page) => repo.fetchChats(currentUserId, page: page),
    );
    unreadMsgs =
        (appStore.pref.getStringList(CHATS_UNREAD_MSGS_KEY) ?? <String>[])
            .asObservable();
  }

  String get currentUserId => Modular.get<AuthController>().currentUser.id;

  Stream<List<User>> get onlineUsers =>
      Modular.get<AuthController>().userRepo.onlineUsers();

  bool isCurrentUser(String id) => currentUserId == id;

  Stream<List<Message>> conversationStream(String userId) =>
      repo.conversationStream(
          Message.getChatId(currentUserId, userId), currentUserId, 5);

  String getSenderId(Chat chat) =>
      ((chat.users ?? [])..remove(currentUserId)).first;

  String getUniqueId(String i1, String i2) =>
      i1.compareTo(i2) <= -1 ? i1 + i2 : i2 + i1;

  ObservableList<String> unreadMsgs;
  @computed
  int get unreadMsgCount => unreadMsgs.length;

  @action
  void removeFromUnreadMsg(String id) {
    unreadMsgs.remove(id);
    appStore.pref.setStringList(CHATS_UNREAD_MSGS_KEY, unreadMsgs);
  }

  @action
  void addToUnreadRead(String id) {
    if (unreadMsgs.contains(id)) return;
    unreadMsgs.add(id);
    appStore.pref.setStringList(CHATS_UNREAD_MSGS_KEY, unreadMsgs);
  }
}
