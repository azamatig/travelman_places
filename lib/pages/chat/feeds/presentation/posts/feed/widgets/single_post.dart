import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../export.dart';
import 'post_widget.dart';
import 'shimmer.dart';

class SinglePostScreen extends StatelessWidget {
  final String postId;

  const SinglePostScreen({Key key, @required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Post',
          style: theme.textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Post>(
          stream: Modular.get<PostRepository>().singlePostStream(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerPost();
            }
            return snapshot.data == null
                ? Container()
                : PostWidget(post: snapshot.data, showMore: false);
          },
        ),
      ),
    );
  }
}
