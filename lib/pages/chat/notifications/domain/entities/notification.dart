import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import 'chat_msg.dart';
import 'comment.dart';
import 'comment_reaction.dart';
import 'comment_reply.dart';
import 'follow.dart';
import 'group_msg.dart';
import 'post_reaction.dart';

export 'chat_msg.dart';
export 'comment.dart';
export 'comment_reaction.dart';
export 'comment_reply.dart';
export 'follow.dart';
export 'group_msg.dart';
export 'post_reaction.dart';

abstract class OtakuNotification {
  final int type;
  final String id, sendToId, fromId, fromName;
  final DateTime time;
  final bool read;

  OtakuNotification({
    @required this.type,
    @required this.id,
    @required this.time,
    @required this.sendToId,
    @required this.read,
    @required this.fromName,
    @required this.fromId,
  });

  String content();

  factory OtakuNotification.fromJson(Map json) {
    switch (json['type']) {
      case 0:
        return FollowNotification.fromJson(json);
      case 1:
        return PostReactionNotification.fromJson(json);
      case 2:
        return PostCommentNotification.fromJson(json);
      case 3:
        return ChatMsgNotification.fromJson(json);
      case 4:
        return CommentReplyNotification.fromJson(json);
      case 5:
        return CommentReactionNotification.fromJson(json);
      case 6:
        return GroupMsgNotification.fromJson(json);
      default:
        Logger().e('Unsupported Notification type');
        return null;
    }
  }

  static Map toJson(OtakuNotification notification) {
    if (notification is FollowNotification) {
      return notification.toJson();
    } else if (notification is PostReactionNotification) {
      return notification.toJson();
    } else if (notification is PostCommentNotification) {
      return notification.toJson();
    } else if (notification is ChatMsgNotification) {
      return notification.toJson();
    } else if (notification is CommentReplyNotification) {
      return notification.toJson();
    } else if (notification is CommentReactionNotification) {
      return notification.toJson();
    } else if (notification is GroupMsgNotification) {
      return notification.toJson();
    }

    Logger().e('Unsupported Notification type');
    throw Exception('Unsupported Notification type');
  }
}
