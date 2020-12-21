import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';
import '../widgets/user_list.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User get user => Modular.get<AuthController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                floating: true,
                flexibleSpace: ProfileHeader(),
                leading: Container(),
                bottom: TabBar(
                  tabs: <Widget>[
                    UserStateWidget(
                      name: t.Auth.posts,
                      value: user.posts.length.toString(),
                    ),
                    UserStateWidget(
                      name: t.Auth.followers,
                      value: user.followers.length.toString(),
                    ),
                    UserStateWidget(
                      name: t.Auth.followig,
                      value: user.following.length.toString(),
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
              UserList(
                usersId: user.followers,
                key: PageStorageKey('2'),
              ),
              UserList(
                usersId: user.following,
                key: PageStorageKey('3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserStateWidget extends StatelessWidget {
  final String name;
  final String value;

  const UserStateWidget({Key key, @required this.name, @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Text(
          name ?? '',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          value ?? '0',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            color: theme.iconTheme.color,
          ),
        ),
      ],
    );
  }
}
