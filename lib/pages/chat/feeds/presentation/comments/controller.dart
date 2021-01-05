import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../export.dart';

part 'controller.g.dart';

class CommentsController = _CommentsController
    with _$CommentsController
    implements Disposable;

abstract class _CommentsController with Store {
  final String postId, postAuthor;
  _CommentsController(this.postId, this.postAuthor);

  final repo = Modular.get<CommentRepository>();
  final _notStore = Modular.get<NotificationController>();

  final scrollController = ScrollController();
  final refreshController = RefreshController(initialRefresh: false);
  final textController = TextEditingController();

  @observable
  var comments = ObservableList<Comment>();

  User get currentUser => Modular.get<AuthController>().currentUser;
  Post get currentPost => Modular.get<FeedController>()
      .posts
      .firstWhere((e) => e.id == postId, orElse: () => null);

  @observable
  int commentsOffset = 20;

  @action
  Future<void> onRefresh() async {
    commentsOffset = comments.length + 10;
    refreshController.loadComplete();
  }

  Stream<List<Comment>> get commentsStream =>
      repo.commentsStream(postId, commentsOffset);

  @action
  Future<void> addComment(String content) async {
    if (ProfanityFilter().hasProfanity(content)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    try {
      final comment = Comment.fromUser(
        currentUser: currentUser,
        content: content,
        postId: postId,
        postAuthorId: postAuthor,
      );
      currentPost?.commentsIds?.add(comment.id);
      comments.insert(0, comment);
      await repo.addComment(comment);
      await _notStore.postCommentNotification(postAuthor, postId);
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> editComment(Comment comment) async {
    if (ProfanityFilter().hasProfanity(comment.content)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    try {
      await repo.updateComment(comment);
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> deleteComment(String commentId) async {
    try {
      comments.removeWhere((c) => c.id == commentId);
      currentPost?.commentsIds?.remove(commentId);
      await repo.removeComment(postId, commentId);
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  @action
  Future<void> addOrRemoveReaction(Comment comment) async {
    try {
      final likeIt = comment.usersLikeIds.contains(currentUser.id);
      if (likeIt) {
        comment.usersLikeIds.remove(currentUser.id);
        await repo.removeCommentReaction(comment, currentUser.id);
      } else {
        comment.usersLikeIds.add(currentUser.id);
        await repo.addCommentReaction(comment, currentUser.id);
        await _notStore.commentReactionNotification(comment);
      }
    } catch (e, s) {
      print(s);
    }
  }

  void dispose() {
    textController.dispose();
    scrollController.dispose();
    refreshController.dispose();
  }
}
