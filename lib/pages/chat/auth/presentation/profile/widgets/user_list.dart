import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'user_item.dart';

class UserList extends StatefulWidget {
  final List<String> usersId;
  final String title;

  const UserList({Key key, @required this.usersId, this.title})
      : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with AutomaticKeepAliveClientMixin {
  final _refreshController = RefreshController(initialRefresh: false);

  int offset = 10;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ids = widget.usersId.take(offset).toList();
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: offset <= ids.length,
      enablePullDown: false,
      onLoading: () async {
        setState(() {
          offset = ids.length + 10;
        });
        _refreshController.loadComplete();
      },
      child: ListView.builder(
        itemCount: ids.length,
        itemBuilder: (_, i) => UserItemWidget(userId: ids[i]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
