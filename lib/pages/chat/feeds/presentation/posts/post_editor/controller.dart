import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../../../export.dart';

part 'controller.g.dart';

class PostEditorController = _PostEditorController
    with _$PostEditorController
    implements Disposable;

abstract class _PostEditorController with Store {
  final postRepo = Modular.get<PostRepository>();
  final _feedController = Modular.get<FeedController>();
  final Post post;

  _PostEditorController({this.post}) {
    textController.text = post?.content ?? '';
    imgUrl = post?.imgUrl ?? '';
    if (imgUrl.isNotEmpty == true) {
      uploadImgListener = UploadState.success(post.imgUrl);
    }
  }
  String imgUrl;
  final textController = TextEditingController();

  User get currentUser => _feedController.currentUser;

  @computed
  bool get allowedToPublish => currentUser.reporters.length < 5;

  @observable
  var uploadImgListener = UploadState.initial();

  void onShareTap() async {
    if (!allowedToPublish) {
      BotToast.showCustomLoading(
        toastBuilder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Sorry! You are not allowed to publish anymore',
              textAlign: TextAlign.center,
            ),
          );
        },
        duration: Duration(seconds: 5),
      );
      return;
    }
    final content = textController.text.trim();
    if (ProfanityFilter().checkStringForProfanity(content)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    imgUrl = await uploadImgListener.maybeWhen(
      imgPicked: (path) {
        BotToast.showLoading();
        return uploadFile(File(path), Constants.POSTS_IMAGES_CHILD_NAME);
      },
      orElse: () => imgUrl,
    );
    if (imgUrl?.isNotEmpty != true) {
      uploadImgListener = UploadState.failed();
      return;
    }
    uploadImgListener = UploadState.success(imgUrl);
    if (post == null) {
      await addPost();
    } else {
      await updatePost();
    }
    BotToast.closeAllLoading();
    Modular.to.pop();
    Modular.get<FeedController>().feedListController.reset();
  }

  void pickImage() async {
    final pickedImage = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 90);
    if (pickedImage == null) {
      BotToast.showText(text: t.Wallpapers.no_img_selected);
      return;
    } else {
      uploadImgListener = UploadState.imgPicked(pickedImage.path);
    }
  }

  @action
  Future<void> addPost() async {
    try {
      final post = Post.fromUser(currentUser, textController.text, imgUrl);
      await postRepo.addPost(post);
      _feedController.posts.add(post);
    } catch (e, s) {
      Logger().e('Error Upload Image', e);
      uploadImgListener = UploadState.failed();
    }
    uploadImgListener = UploadState.initial();
  }

  @action
  Future<void> updatePost() async {
    try {
      final content = textController.text;
      post
        ..content = content
        ..imgUrl = imgUrl;
      await postRepo.updatePost(post.id, content, imgUrl);
    } catch (e, s) {
      Logger().e(e);
    }
  }

  @action
  Future<void> deletePost() async {
    try {
      await postRepo.removePost(post.id, post.authorId, post.commentsIds);
      _feedController.posts.remove(post);
    } catch (e, s) {
      Logger().e(e);
    }
  }

  void dispose() {
    textController.dispose();
  }
}
