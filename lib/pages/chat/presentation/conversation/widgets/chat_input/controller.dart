import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../../export.dart';

part 'controller.g.dart';

class ChatInputController = _ChatInputController
    with _$ChatInputController
    implements Disposable;

abstract class _ChatInputController with Store {
  final VoidCallback _onSend;
  final Message toEditMessage;
  _ChatInputController(this._onSend, this.toEditMessage) {
    controller.text = toEditMessage?.content;
  }

  final repo = Modular.get<ChatRepository>();

  final controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }

  final conversationCon = Modular.get<ConversationCon>();

  User get currentUser => conversationCon.currentUser;
  String get otherUserId => conversationCon.userId;

  @observable
  bool isTyping = false;

  @action
  Future<void> sendTextMessage({String message}) async {
    final msgContent = message ?? controller.text.trim();
    if (msgContent.isEmpty) return;
    if (ProfanityFilter().hasProfanity(msgContent)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }

    if (toEditMessage != null) {
      return editTextMessage(msgContent);
    }
    try {
      final msg = Message.fromUser(
        currentUser: currentUser,
        sendToId: otherUserId,
        content: msgContent,
        type: MessageType.Text.index,
      );
      conversationCon.mergeMsgs([msg]);
      controller.clear();
      isTyping = false;

      _onSend();
      await repo.sendMessage(msg);
      // Logger().i('Message Sent');
    } catch (e, s) {
      print(s);
    }
  }

  @action
  Future<void> editTextMessage(String message) async {
    final msgContent = message ?? controller.text.trim();
    if (msgContent.isEmpty) return;
    try {
      _onSend();
      final index = conversationCon.msgs.indexOf(toEditMessage);
      if (index != -1) {
        conversationCon.msgs[index] =
            conversationCon.msgs[index].copyWith(content: controller.text);
      }
      await repo.editMessage(
        chatId: toEditMessage.chatId,
        msgId: toEditMessage.id,
        content: controller.text,
      );
    } catch (e, s) {
      print(s);
    }
  }

  @action
  Future<void> onSendImage(BuildContext context) async {
    final imageFile = await showImageSourceSelectorDialog(context);
    if (imageFile != null) {
      try {
        var msg = Message.fromUser(
          currentUser: currentUser,
          sendToId: otherUserId,
          localPath: imageFile.path,
          type: MessageType.Image.index,
        );
        conversationCon.mergeMsgs([msg]);
        await repo.sendMessage(msg);

        _onSend();
        final imgUrl = await uploadFile(imageFile, Constants.IMAGES_CHILD_NAME);
        msg = msg.copyWith(
          content: imgUrl,
          localPath: null,
        );
        await repo.sendMessage(msg);
      } catch (e, s) {
        print(s);
      }
    }
  }

  bool isBlocked(User user) => !user.blockedUsers.contains(currentUser.id);
}
