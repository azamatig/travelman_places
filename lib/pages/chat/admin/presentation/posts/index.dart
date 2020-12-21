import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'package:travelman/pages/chat/i18n/strings.g.dart';

import '../../export.dart';
import 'post_widget.dart';

class ReportedPosts extends StatelessWidget {
  final repo = m.Modular.get<AdminRepo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.Admin.posts),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Post>>(
        stream: repo.reportedPostsStream(),
        builder: (_, snap) {
          final posts = snap.data ?? <Post>[];
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => PostWidget(post: posts[i]),
          );
        },
      ),
    );
  }
}
