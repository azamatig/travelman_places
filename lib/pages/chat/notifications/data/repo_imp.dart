import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../export.dart';

class NotificationsRepoImp extends NotificationReposity {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference _notificationCollection(String userId) =>
      _firestore.collection('users/$userId/notifications');

  @override
  Stream<List<OtakuNotification>> notificationsStream(
      String userId, int offset) {
    return _notificationCollection(userId)
        .orderBy('time', descending: true)
        .limit(offset)
        .snapshots()
        .map((s) =>
            [for (final doc in s.docs) OtakuNotification.fromJson(doc.data())]);
  }

  @override
  Stream<List<OtakuNotification>> unreadNotificationsStream(String userId) {
    return _notificationCollection(userId)
        .where('read', isEqualTo: false)
        .snapshots()
        .map((s) =>
            [for (final doc in s.docs) OtakuNotification.fromJson(doc.data())]);
  }

  @override
  Future<void> sendNotificaion(OtakuNotification not) {
    return _notificationCollection(not.sendToId)
        .doc(not.id)
        .set(OtakuNotification.toJson(not))
        .catchError(Logger().e);
  }

  @override
  Future<void> markReadNotificaion(OtakuNotification not) {
    return _notificationCollection(not.sendToId)
        .doc(not.id)
        .update({'read': true});
  }
}
