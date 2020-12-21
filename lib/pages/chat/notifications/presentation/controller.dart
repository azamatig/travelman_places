import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travelman/pages/chat/presentation/chats/controller.dart';
import '../export.dart';

part 'controller.g.dart';

const LAST_NOT_ID = 'last-notification-id';
class NotificationController = _NotificationController
    with _$NotificationController;

abstract class _NotificationController with Store {
  final repository = Modular.get<NotificationReposity>();
  final chatController = Modular.get<ChatController>();
  final refreshController = RefreshController(initialRefresh: false);
  User get currentUser => Modular.get<AuthController>().currentUser;

  var _userLocation;
  void updateUserLocation(UserNavigationTracker v) {
    _userLocation = v;

    v.maybeWhen(
        chatting: chatController.removeFromUnreadMsg, orElse: () => null);
  }

  Future<void> onMessageNotificationReceived(
      {String senderName, String senderId, String message}) async {
    // Logger().i('FCM OnMessage ${message}');
    void _showNotification() {
      try {
        chatController.addToUnreadRead(senderId);
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.receivedMessage,
        );
        showNotification(senderName, message, () {
          onMessageNotificationOpened(senderId);
        });
      } catch (e, s) {
        Logger().e(e);
      }
    }

    _userLocation.maybeWhen(
      chatting: (id) {
        if (id != senderId) {
          _showNotification();
        }
      },
      orElse: _showNotification,
    );
  }

  Future<void> onMessageNotificationOpened(String senderId) async {
    chatController.addToUnreadRead(senderId);
    //  NotificationState.newMessageRecieved(userId: senderId);
  }

  Future<void> groupMessageNotificationReceived(
      {String groupName,
      String groupId,
      String senderName,
      String message}) async {
    _userLocation.maybeWhen(
      groupChatting: (group) {
        if (group.id == groupId) return;

        try {
          showNotification(groupName, '$senderName: $message', () {
            groupMessageNotificationOpened(groupId);
          });
          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.receivedMessage,
          );
        } catch (e, s) {
          Logger().e(e);
        }
      },
      orElse: () => null,
    );
  }

  Future<void> groupMessageNotificationOpened(String groupId) async {
    final group = await Modular.get<GroupsController>().repo.getGroup(groupId);
    await GroupsModule.toGroup(group);
  }

  Future<void> otherNotificationReceived(OtakuNotification e) async {
    print('Other Notification');
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (_) => CustomNotificationWidget(
        senderName: e.fromName,
        message: e.content(),
        onTap: (context) {
          BotToast.cleanAll();
          onNotificationTap(context, e);
        },
      ),
    );
    await FlutterRingtonePlayer.playNotification();
  }

  Stream<List<OtakuNotification>> notificationsStream(int offset) =>
      repository.notificationsStream(currentUser.id, offset);

  Stream<List<OtakuNotification>> unreadNotificationsStream() {
    return repository.unreadNotificationsStream(currentUser.id);
  }

  DateTime get now => DateTime.now().toUtc();
  Future<void> sendFollowNotification(String sendToId) {
    final followerId = currentUser.id;
    final not = FollowNotification(
      id: 'follow-$followerId-$sendToId',
      sendToId: sendToId,
      followerId: followerId,
      followerName: currentUser.name,
      time: now,
    );
    return repository.sendNotificaion(not);
  }

  Future<void> postLikeNotification(String authorId, String postId) {
    if (currentUser.id == authorId) return null;
    final likeOwner = currentUser.id;
    final not = PostReactionNotification(
      id: 'like-$likeOwner-$authorId',
      postAuthor: authorId,
      postId: postId,
      likeOwnerId: likeOwner,
      likeOwnerName: currentUser.name,
      time: now,
    );
    return repository.sendNotificaion(not);
  }

  Future<void> postCommentNotification(String authorId, String postId) {
    if (currentUser.id == authorId) return null;
    final commentOwnerId = currentUser.id;
    final not = PostCommentNotification(
      id: 'comment-${now.millisecondsSinceEpoch}-$commentOwnerId-$authorId',
      postAuthor: authorId,
      postId: postId,
      commentOwnerId: commentOwnerId,
      commentOwnerName: currentUser.name,
      time: now,
    );
    return repository.sendNotificaion(not);
  }

  Future<void> commentReplyNotification(Comment comment) {
    if (currentUser.id == comment.authorId) return null;

    final replyOwner = currentUser.id;
    final not = CommentReplyNotification(
      id: 'comment_reply-${now.millisecondsSinceEpoch}-$replyOwner-${comment.authorId}',
      postAuthorId: comment.postAuthorId,
      postId: comment.postId,
      commentId: comment.id,
      commentOwnerId: comment.authorId,
      time: now,
      replyId: replyOwner,
      replyOwnerName: currentUser.name,
    );
    return repository.sendNotificaion(not);
  }

  Future<void> commentReactionNotification(Comment comment) {
    if (currentUser.id == comment.authorId) return null;
    final reactionOwner = currentUser.id;
    final not = CommentReactionNotification(
      id: 'comment_reaction-${comment.id}-$reactionOwner-${comment.authorId}',
      postAuthorId: comment.postAuthorId,
      postId: comment.postId,
      commentOwnerId: comment.authorId,
      reactionOwnerId: reactionOwner,
      reactionOwnerName: currentUser.name,
      time: now,
    );
    return repository.sendNotificaion(not);
  }

  Future<void> markReadNotificatin(OtakuNotification not) {
    if (not.read == true) return null;
    return repository.markReadNotificaion(not);
  }

  void onNotificationTap(BuildContext context, OtakuNotification notification) {
    switch (notification.runtimeType) {
      case PostReactionNotification:
        FeedsModule.toPost((notification as PostReactionNotification).postId);
        break;
      case PostCommentNotification:
        FeedsModule.toPost((notification as PostCommentNotification).postId);
        break;
      case FollowNotification:
        AuthModule.toOtherUserProfile(
            (notification as FollowNotification).followerId);
        break;
      case CommentReplyNotification:
        final n = (notification as CommentReplyNotification);
        FeedsModule.toComments(n.postId, n.postAuthorId);

        break;
      case CommentReactionNotification:
        final n = (notification as CommentReactionNotification);
        FeedsModule.toComments(n.postId, n.postAuthorId);

        break;
      default:
    }
  }

  void showNotification(String senderName, String message, VoidCallback onTap) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (_) => CustomNotificationWidget(
        senderName: senderName,
        message: message,
        onTap: (_) {
          BotToast.cleanAll();
          onTap();
        },
      ),
    );
  }
}
