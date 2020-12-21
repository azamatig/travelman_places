import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';

class NotificationModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => NotificationsRepoImp()),
        m.Bind((i) => NotificationController()),
        m.Bind((i) => NotificationsHelper()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(NOTIFICATIONS,
            child: (_, args) => NotificationScreen()),
      ];

  static const NOTIFICATIONS = '/notifications';
  static Future toNotifications() => m.Modular.to.pushNamed(NOTIFICATIONS);
}
