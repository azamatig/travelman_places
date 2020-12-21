import 'package:meta/meta.dart';
import '../../export.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message);

  Future<List<Chat>> fetchChats(String userId, {int page});
  Stream<List<Message>> conversationStream(
      String chatId, String currentUserId, int offset);
  Future<void> removeConversation(String chatId, String currentUserId);

  void markReadMsgs(String chatId, List<String> msgs);

  Future<void> editMessage({
    @required String chatId,
    @required String msgId,
    @required String content,
  });

  Future<void> deleteMessage({
    @required String chatId,
    @required String msgId,
  });
}
