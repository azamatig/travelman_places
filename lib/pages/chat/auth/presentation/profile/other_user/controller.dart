import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../export.dart';

part 'controller.g.dart';

class OtherUserProfileController = _OtherUserProfileController
    with _$OtherUserProfileController;

abstract class _OtherUserProfileController with Store {
  final String otherUserId;
  _OtherUserProfileController(this.otherUserId);

  final userRepo = Modular.get<UserRepository>();

  @observable
  User otherUser;

  User get currentUser => Modular.get<AuthController>().currentUser;

  Stream<User> get userStream => userRepo.getUserStream(otherUserId);

  @computed
  bool get isFollowing => currentUser.following.contains(otherUserId);

  void followUser(String userId) async {
    if (isFollowing) {
      currentUser.following.remove(userId);
      otherUser.followers.remove(currentUser.id);
      await userRepo.unFollowUser(currentUser.id, userId);
    } else {
      currentUser.following.add(userId);
      otherUser.followers.add(currentUser.id);
      await userRepo.followUser(currentUser.id, userId);
      await Modular.get<NotificationController>()
          .sendFollowNotification(userId);
    }
  }

  void banUser() async {
    try {
      BotToast.showLoading();
      await userRepo.banUser(otherUserId);
    } catch (e) {
      print(e);
    }
    BotToast.closeAllLoading();
  }
}
