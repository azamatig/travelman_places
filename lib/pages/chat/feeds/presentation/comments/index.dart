import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../export.dart';
import '../comments/widgets/shimmer.dart';
import 'controller.dart';
import 'widgets/comment_widget.dart';
import 'widgets/input.dart';

class CommentsScreen extends WidgetModule {
  final String postId, postAuthorId;

  CommentsScreen(this.postId, this.postAuthorId);

  @override
  List<Bind> get binds =>
      [Bind((_) => CommentsController(postId, postAuthorId))];

  @override
  Widget get view => _CommentsScreen();
}

class _CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState
    extends ModularState<_CommentsScreen, CommentsController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.Feed.comments,
          style: theme.textTheme.headline6,
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
              stream: controller.commentsStream,
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return CommentShimmer();
                }
                controller.comments =
                    ObservableList.of(snap.data ?? controller.comments);
                return SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: false,
                  enablePullDown:
                      controller.commentsOffset <= controller.comments.length,
                  dragStartBehavior: DragStartBehavior.down,
                  onRefresh: controller.onRefresh,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    itemCount: controller.comments.length,
                    itemBuilder: (_, index) =>
                        CommentWidget(comment: controller.comments[index]),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          CommentInput(
            onSubmit: (content) async {
              if (content.isEmpty) return;
              await Future.delayed(Duration(milliseconds: 50))
                  .then((_) => controller.textController.clear());
              await controller.addComment(content);
            },
          ),
        ],
      ),
    );
  }
}
