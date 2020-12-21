import '../../export.dart';

abstract class NotificationReposity {

  Stream<List<OtakuNotification>> notificationsStream(
      String userId, int offset);

  Stream<List<OtakuNotification>> unreadNotificationsStream(String userId);

  Future<void> sendNotificaion(OtakuNotification not);

  Future<void> markReadNotificaion(OtakuNotification not);
}
