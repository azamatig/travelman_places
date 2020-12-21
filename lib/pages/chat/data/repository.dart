import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../export.dart';

class ChatRepoImp extends ChatRepository {
  final _firestore = FirebaseFirestore.instance;
  CollectionReference get _chatCollection => _firestore.collection('chats');
  DocumentReference _chatDocument(String chatId) => _chatCollection.doc(chatId);

  CollectionReference _conversationCollection(String chatId) =>
      _chatDocument(chatId).collection('messages');

  DocumentReference _messageDocument(String chatId, String msgId) =>
      _conversationCollection(chatId).doc(msgId);

  DocumentSnapshot lastChatDoc;
  @override
  Future<List<Chat>> fetchChats(String userId, {int page}) async {
    var query = _chatCollection
        .where('visibleTo', arrayContains: userId)
        .orderBy('updateTime', descending: true)
        .limit(10);
    if (page != 1 && lastChatDoc != null) {
      query = query.startAfterDocument(lastChatDoc);
    }
    final docs = (await query.get()).docs;
    if (docs.isNotEmpty) {
      lastChatDoc = docs.last;
    }
    return [for (final doc in docs) Chat.fromJson(doc.data())];
  }

  @override
  Future<void> sendMessage(Message message) async {
    try {
      final doc = await _chatCollection.doc(message.chatId).get();
      //Create new chat document --> first discussion
      if (doc.data() == null) {
        await doc.reference.set(
          Chat.fromMessage(message).toJson()
            ..['updateTime'] = FieldValue.serverTimestamp()
            ..['createdAt'] = FieldValue.serverTimestamp(),
        );
      } else {
        await doc.reference.update({
          'updateTime': FieldValue.serverTimestamp(),
          'visibleTo': message.visibleTo
        });
      }
      await _messageDocument(message.chatId, message.id).set(
        message.toJson()..['time'] = FieldValue.serverTimestamp(),
      );
      // await saveRecentChat(message);
    } catch (e) {
      Logger().e(e);
      throw Exception();
    }
  }

  @override
  Future<void> editMessage({
    @required String chatId,
    @required String msgId,
    @required String content,
  }) async {
    await _messageDocument(chatId, msgId).update({'content': content});
  }

  @override
  Future<void> deleteMessage({
    @required String chatId,
    @required String msgId,
  }) async {
    await _messageDocument(chatId, msgId).delete();
  }

  @override
  Stream<List<Message>> conversationStream(
      String chatId, String currentUserId, int offset) {
    return _conversationCollection(chatId)
        .orderBy('time', descending: true)
        .where('visibleTo', arrayContains: currentUserId)
        .limit(offset)
        .snapshots()
        .map(
          (s) => [for (final doc in s.docs) Message.fromJson(doc.data())],
        );
  }

  @override
  void markReadMsgs(String chatId, List<String> msgs) {
    for (final id in msgs) {
      _messageDocument(chatId, id).update({'read': true}).catchError(
        (e) => Logger().e(e),
      );
    }
  }

  @override
  Future<void> removeConversation(String chatId, String currentUserId) async {
    await _chatDocument(chatId).update({
      'visibleTo': FieldValue.arrayRemove([currentUserId])
    });
    final docs = await _conversationCollection(chatId).get();

    for (final doc in docs.docs) {
      await doc.reference.update({
        'visibleTo': FieldValue.arrayRemove([currentUserId])
      });
    }
  }
}
