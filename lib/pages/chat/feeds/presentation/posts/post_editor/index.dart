import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../export.dart';
import '../widgets/user_avatar.dart';
import 'controller.dart';

class PostEditor extends WidgetModule {
  final Post toEditPost;

  PostEditor({this.toEditPost});

  @override
  List<Bind> get binds => [Bind((_) => PostEditorController(post: toEditPost))];

  @override
  Widget get view => _PostEditor();
}

class _PostEditor extends StatefulWidget {
  @override
  _PostEditorState createState() => _PostEditorState();
}

class _PostEditorState extends ModularState<_PostEditor, PostEditorController> {
  @override
  Widget build(BuildContext context) {
    print('Post Editor ${controller.post}');
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: theme.textTheme.headline6,
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Text(
                'Share',
                style: GoogleFonts.acme(
                  textStyle: theme.textTheme.subtitle1.copyWith(fontSize: 20),
                ),
              ),
            ),
            onTap: controller.onShareTap,
          ),
          controller.post == null
              ? SizedBox(width: 10)
              : PopupMenuButton<int>(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete),
                            SizedBox(width: 4),
                            Text('delete'),
                            SizedBox(width: 4),
                          ],
                        )),
                  ],
                  onSelected: (v) {
                    if (v == 0) {
                      showDeleteAlertDialog(
                        context,
                        () {
                          controller.deletePost();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Modular.get<FeedController>()
                              .feedListController
                              .reset();
                        },
                      );
                    }
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                UserAvatar(
                  photo: controller.currentUser.photoUrl,
                  radius: 40,
                  showBadge: false,
                ),
                SizedBox(width: 12),
                Text(
                  controller.currentUser.name,
                  style: theme.textTheme.bodyText2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // IconButton(
                //   icon: Icon(Icons.photo_library),
                //   onPressed: () => controller.pickImage(),
                // )
              ],
            ),
            SizedBox(height: 20),
            TextField(
              style: theme.textTheme.headline5,
              controller: controller.textController,
              maxLines: null,
              decoration: InputDecoration.collapsed(
                hintText: t.Feed.what_on_mind,
                hintStyle:
                    theme.textTheme.headline5.copyWith(color: Colors.grey),
              ),
              // focusNode: focusNode,
            ),
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 400),
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Observer(
                builder: (_) {
                  return controller.uploadImgListener.when<Widget>(
                    initial: () => IconButton(
                      icon: Icon(Icons.add, size: 50),
                      onPressed: controller.pickImage,
                    ),
                    imgPicked: (path) => Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Image.file(
                              File(path),
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -25,
                          top: -6,
                          child: MaterialButton(
                            splashColor: Colors.red,
                            color: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                            child: Icon(Icons.close),
                            onPressed: () {
                              controller.uploadImgListener =
                                  UploadState.initial();
                            },
                          ),
                        ),
                      ],
                    ),
                    success: (e) => CachedNetworkImage(
                      imageUrl: controller.imgUrl,
                      errorWidget: (_, __, ___) => Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    failed: () => GestureDetector(
                      onTap: controller.pickImage,
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.warning,
                            size: 40,
                          ),
                          SizedBox(height: 4),
                          Text(t.Wallpapers.failed_to_upload)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
