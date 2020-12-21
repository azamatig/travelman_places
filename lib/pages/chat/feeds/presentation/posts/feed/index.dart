import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../export.dart';
import '../widgets/add_post_widget.dart';
import '../widgets/sorting_widget.dart';
import 'controller.dart';
import 'widgets/img_post.dart';
import 'widgets/post_widget.dart';
import 'widgets/shimmer.dart';

class FeedScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<FeedScreen> {
  final controller = Modular.get<FeedController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: controller.scaffoldKey,
      primary: true,
      drawer: HomeDrawer(),
      body: Observer(
        builder: (_) => CustomScrollView(
          controller: controller.scrolleController,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              floating: true,
              primary: true,
              title: Text(
                t.Feed.title,
                style: GoogleFonts.abrilFatface(
                    textStyle:
                        theme.textTheme.headline6.copyWith(fontSize: 24)),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: theme.iconTheme.color,
                ),
                onPressed: () =>
                    controller.scaffoldKey.currentState.openDrawer(),
              ),
              actions: <Widget>[ChatIcon()],
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 40),
                child: PostsSortingWidget(
                  postQuery: controller.postQuery,
                  onChange: controller.changePostQuery,
                ),
              ),
            ),
            controller.postQuery.maybeWhen(
              orElse: () => PagewiseSliverList<Post>(
                pageLoadController: controller.feedListController,
                itemBuilder: (_, post, i) => Column(
                  children: <Widget>[
                    if (i == 0) AddPostWidget(),
                    PostWidget(post: post),
                  ],
                ),
                loadingBuilder: (_) => ShimmerPost(),
                noItemsFoundBuilder: (_) => AddPostWidget(),
              ),
              gallery: () => PagewiseSliverGrid<Post>.count(
                pageLoadController: controller.feedListController,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (_, post, i) => ImagePostWidget(
                  post: post,
                  onTap: () => AppModule.showFullImage(post.imgUrl),
                ),
                loadingBuilder: (_) => SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
