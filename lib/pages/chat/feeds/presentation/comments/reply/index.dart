import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';
import '../widgets/input.dart';
import 'controller.dart';
import 'widgets/reply_widget.dart';

class ReplyScreen extends WidgetModule {
  final String postId, commentId;
  ReplyScreen(this.postId, this.commentId);

  @override
  List<Bind> get binds => [Bind((_) => ReplyController(postId, commentId))];

  @override
  Widget get view => _ReplyScreen();
}

class _ReplyScreen extends StatefulWidget {
  @override
  _ReplyScreenState createState() => _ReplyScreenState();
}

class _ReplyScreenState extends ModularState<_ReplyScreen, ReplyController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.Feed.replies,
          style: theme.textTheme.headline6,
        ),
      ),
      body: StreamBuilder<Comment>(
        stream: controller.singleCommentStream,
        builder: (context, snapshot) {
          final comment = snapshot.data;
          if (comment == null) return Container();
          return Column(
            children: <Widget>[
              AbsorbPointer(
                child:
                    ReplyWidget(comment: comment, commentParentId: comment.id),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: comment.replyComments?.length ?? 0,
                    itemBuilder: (context, index) => ReplyWidget(
                        comment: comment.replyComments[index],
                        commentParentId: comment.id),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CommentInput(
                onSubmit: (content) {
                  controller.addReplyComment(
                      content: content, comment: comment);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
