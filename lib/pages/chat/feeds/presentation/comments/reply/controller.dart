import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../export.dart';
part 'controller.g.dart';

class ReplyController = _ReplyControllerBase
    with _$ReplyController
    implements Disposable;

abstract class _ReplyControllerBase with Store {
  final String postId, commentId;
  _ReplyControllerBase(this.postId, this.commentId);
  final repo = Modular.get<CommentRepository>();
  final _notStore = Modular.get<NotificationController>();

  final scrollController = ScrollController();
  final refreshController = RefreshController(initialRefresh: false);

  User get currentUser => Modular.get<AuthController>().currentUser;

  Stream<Comment> get singleCommentStream =>
      repo.singleCommentStream(commentId);

  @observable
  int offset = 10;

  @action
  Future<void> addReplyComment(
      {@required Comment comment, @required String content}) async {
    try {
      final reply = Comment.fromUser(
          currentUser: currentUser,
          content: content,
          postId: comment.postId,
          postAuthorId: comment.postAuthorId,
          parentId: comment.id);
      await repo.addCommentReply(comment.id, reply);
      comment.replyComments.add(reply);
      await _notStore.commentReplyNotification(comment);
    } catch (e, s) {
      Logger().e(e);
    }
  }

  @action
  Future<void> removeReplyComment(String parentId, Comment reply) async {
    try {
      await repo.removeCommentReply(parentId, reply);
    } catch (e, s) {
      Logger().e(e);
    }
  }

//  @action
//   Future<void> addOrRemoveReaction(Comment comment) async {
//     try {
//       bool likeIt = comment.usersLikeIds.contains(currentUser.id);
//       if (likeIt) {
//         comment.usersLikeIds.remove(currentUser.id);
//         await repo.removeCommentReaction(comment, currentUser.id);
//       } else {
//         comment.usersLikeIds.add(currentUser.id);
//         await repo.addCommentReaction(comment, currentUser.id);
//         await _notStore.commentReactionNotification(comment);
//       }
//     } catch (e, s) {
//       await Crashlytics.instance.recordError(e, s);
//     }
//   }
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
  }
}
