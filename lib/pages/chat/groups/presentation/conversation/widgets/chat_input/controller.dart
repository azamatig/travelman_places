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
  final repo = Modular.get<GroupsRepository>();
  final conversationCon = Modular.get<ConversationCon>();
  final VoidCallback _onSend;
  final Message toEditMessage;
  _ChatInputController(this._onSend, this.toEditMessage);

  final controller = TextEditingController();

  User get currentUser => conversationCon.currentUser;
  String get groupId => conversationCon.group.id;

  @observable
  bool isImageUploading = false;
  @action
  Future<void> onSendMessage({String message}) async {
    // type: 0 = text, 1 = img
    final msgContent = message ?? controller.text.trim();
    if (msgContent.isEmpty) return;
    if (ProfanityFilter().checkStringForProfanity(msgContent)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    try {
      if (toEditMessage == null) {
        final msg = Message.fromUser(
          currentUser: currentUser,
          groupId: groupId,
          content: msgContent,
          type: 0,
        );

        conversationCon.mergeMsgs([msg]);
        controller.clear();
        isTyping = false;

        _onSend();
        await repo.sendMessage(msg);
      } else {
        _onSend();
        await repo.editMessage(
          groupId: groupId,
          msgId: toEditMessage.id,
          content: controller.text,
        );
      }
    } catch (e, s) {}
  }

  @action
  Future<void> onSendImage(BuildContext context) async {
    final imageFile = await showImageSourceSelectorDialog(context);
    if (imageFile != null) {
      try {
        var msg = Message.fromUser(
          currentUser: currentUser,
          groupId: groupId,
          localPath: imageFile.path,
          type: 1,
        );
        conversationCon.mergeMsgs([msg]);
        isImageUploading = true;
        await repo.sendMessage(msg);

        _onSend();

        final imgUrl = await uploadFile(
            imageFile, 'Groups/${conversationCon.group.name}/');
        msg = msg.copyWith(
          content: imgUrl,
          localPath: null,
        );
        isImageUploading = false;
        await repo.sendMessage(msg);
      } catch (e, s) {}
    }
  }

  bool isBlocked(User user) => !user.blockedUsers.contains(currentUser.id);

  @observable
  bool isTyping = false;

  void dispose() {
    controller.dispose();
  }
}
