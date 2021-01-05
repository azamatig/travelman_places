import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import '../../../export.dart';

part 'controller.g.dart';

class FeedController = _FeedControllerBase
    with _$FeedController
    implements Disposable;

abstract class _FeedControllerBase with Store {
  final repo = Modular.get<PostRepository>();

  PagewiseLoadController<Post> feedListController;
  _FeedControllerBase() {
    feedListController = PagewiseLoadController(
      pageSize: 10,
      pageFuture: (pageIndex) =>
          repo.fetchPosts(postQuery, currentUser.id, pageIndex),
    );
  }
  final scrolleController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _notStore = Modular.get<NotificationController>();

  User get currentUser => Modular.get<AuthController>().currentUser;

  var posts = <Post>[];

  @observable
  PostQuery postQuery = PostQuery.newest();

  @observable
  Post selectedPost;

  Future<List<Post>> fetchPosts(int page) =>
      repo.fetchPosts(postQuery, currentUser.id, page);

  @action
  Future<void> changePostQuery(PostQuery v) async {
    postQuery = v;
    scrolleController.jumpTo(0);
    feedListController.reset();
  }

  void addOrRemoveReaction(post) async {
    try {
      if (post.usersLikes.contains(currentUser.id)) {
        post.usersLikes.remove(currentUser.id);
        await repo.removePostReaction(post.id, currentUser.id);
      } else {
        post.usersLikes.add(currentUser.id);
        await repo.addPostReaction(post.id, currentUser.id);
        if (currentUser.id != post.authorId) {
          await _notStore.postLikeNotification(post.authorId, post.id);
        }
      }
    } catch (e, s) {
      Logger().e(e);
      print(s);
    }
  }

  void reportPost(Post post) async {
    try {
      post.reportUsers.add(currentUser.id);
      await repo.reportPost(post, currentUser.id);
    } catch (e, s) {
      Logger().e('Error reporting post', e);
      print(s);
    }
  }

  void dispose() {
    scrolleController.dispose();
  }
}
