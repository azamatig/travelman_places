import 'package:flutter/material.dart';
import 'package:travelman/pages/user_posts/uploader_view.dart';

class PostUploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Uploader()),
    );
  }
}
