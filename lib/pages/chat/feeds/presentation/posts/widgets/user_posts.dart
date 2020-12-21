import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../export.dart';
import '../feed/widgets/post_widget.dart';
import '../feed/widgets/shimmer.dart';

class UserPosts extends StatefulWidget {
  final String userId;

  const UserPosts({Key key, @required this.userId}) : super(key: key);
  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  var offset = 10;
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: Modular.get<PostRepository>()
          .getUserPostsStream(widget.userId, offset),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return ShimmerPost();
        }
        final posts = snap.data ?? [];

        return posts.isEmpty
            ? Container()
            : SmartRefresher(
                controller: _refreshController,
                enablePullUp: offset <= posts.length,
                enablePullDown: false,
                onLoading: () async {
                  setState(() {
                    offset = posts.length + 10;
                  });
                  await Future.delayed(Duration(seconds: 2));
                  _refreshController.loadComplete();
                },
                child: ListView.builder(
                  key: PageStorageKey('user_posts'),
                  itemCount: posts.length,
                  itemBuilder: (_, i) => PostWidget(post: posts[i]),
                ),
              );
      },
    );
  }
}
