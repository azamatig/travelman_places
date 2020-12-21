import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';

import '../../export.dart';

part 'post_query.freezed.dart';

@freezed
abstract class PostQuery with _$PostQuery {
  const factory PostQuery.newest() = _Newest;
  const factory PostQuery.gallery() = _Gallery;
  const factory PostQuery.myPosts() = _MyPosts;
  const factory PostQuery.myFavorites() = _MyFavorites;

  static const values = [
    PostQuery.newest(),
    PostQuery.gallery(),
    PostQuery.myPosts(),
    PostQuery.myFavorites(),
  ];
}

extension PExt on PostQuery {
  String get text {
    return when<String>(
      newest: () => t.Feed.newest,
      gallery: () => t.Feed.gallery,
      myPosts: () => t.Feed.my_posts,
      myFavorites: () => t.Feed.favorite,
    );
  }
}
