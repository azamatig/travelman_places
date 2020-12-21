import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';

class ChatModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => ChatRepoImp()),
        m.Bind((i) => ChatController()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(CHATS, child: (_, args) => ChatScreen()),
        m.ModularRouter('$CHATS/:userId',
            child: (_, args) => Conversation(args.params['userId'])),
      ];

  static const CHATS = '/chats';

  static Future<void> toChats() => m.Modular.to.pushNamed(CHATS);
  static Future<void> toConversation(String id) async {
    final notController = m.Modular.get<NotificationController>();
    notController.updateUserLocation(UserNavigationTracker.chatting(id));
    await m.Modular.to.pushNamed('$CHATS/$id');
    notController.updateUserLocation(UserNavigationTracker.onChatScreen());
  }
}
