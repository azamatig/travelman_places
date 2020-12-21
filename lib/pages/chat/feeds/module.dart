import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';
import 'presentation/posts/feed/widgets/report.dart';

class FeedsModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => PostRepoImp()),
        m.Bind((i) => CommentRepoImp()),
        m.Bind((i) => FeedController()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(FEED, child: (_, args) => FeedScreen()),
        m.ModularRouter(
          '$POST/:id',
          child: (_, args) => SinglePostScreen(postId: args.params['id']),
        ),
        m.ModularRouter(CREATE_POST, child: (_, args) => PostEditor()),
        m.ModularRouter(
          '$COMMENTS/:postId/:authorId',
          child: (_, args) =>
              CommentsScreen(args.params['postId'], args.params['authorId']),
        ),
        m.ModularRouter(
          '$REPLY/:postId/:commentId',
          child: (_, args) =>
              ReplyScreen(args.params['postId'], args.params['commentId']),
        ),
      ];

  static const FEED = '/feed',
      POST = '/post',
      CREATE_POST = '/create_post',
      COMMENTS = '/comments',
      REPLY = '/reply',
      REACTIONS = '/reactions';

  static Future toPost(String id) => m.Modular.to.pushNamed('$POST/$id');
  static Future toComments(String postId, String authorId) =>
      m.Modular.to.pushNamed('$COMMENTS/$postId/$authorId');
  static Future toReply(String postId, String commentId) =>
      m.Modular.to.pushNamed('$REPLY/$postId/$commentId');
  static Future toCreatPost() => m.Modular.to.pushNamed(CREATE_POST);
  static Future toEditPost(Post post) => _to(PostEditor(toEditPost: post));
  static Future toReactions(List<String> ids) =>
      _to(ReactionsScreen(likesId: ids));
  static Future toReportPost(Post post) => _to(ReportScreen(post: post));

  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
