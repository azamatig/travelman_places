import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';
import '../widgets/user_list.dart';
import 'controller.dart';
import 'widgets/profile_header.dart';

class OtherUserProfile extends WidgetModule {
  final String userId;

  OtherUserProfile(this.userId);

  @override
  List<Bind> get binds =>
      [Bind((_) => OtherUserProfileController(userId), singleton: false)];

  @override
  Widget get view => _OtherUserProfile();
}

class _OtherUserProfile extends StatefulWidget {
  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState
    extends ModularState<_OtherUserProfile, OtherUserProfileController> {
  User get user => controller.otherUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: controller.userStream,
      builder: (_, snapshot) {
        controller.otherUser = snapshot.data;
        if (controller.otherUser == null) return Container();
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              controller: ScrollController(),
              headerSliverBuilder: (_, value) {
                return [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    floating: true,
                    flexibleSpace: OProfileHeader(controller: controller),
                    leading: Container(),
                    bottom: TabBar(
                      tabs: <Widget>[
                        UserStateWidget(
                          name: t.Auth.posts,
                          value: user.posts.length.toString(),
                        ),
                        Observer(
                          builder: (_) => UserStateWidget(
                            name: t.Auth.followers,
                            value: user.followers.length.toString(),
                          ),
                        ),
                        Observer(
                          builder: (_) => UserStateWidget(
                            name: t.Auth.followig,
                            value: user.following.length.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  UserPosts(
                    userId: user.id,
                    key: PageStorageKey('0'),
                  ),
                  Observer(
                    builder: (_) => UserList(
                      usersId: user.followers,
                      key: PageStorageKey('followers${user.followers.length}'),
                    ),
                  ),
                  Observer(
                    builder: (_) => UserList(
                      usersId: user.following,
                      key: PageStorageKey('followers${user.following.length}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
