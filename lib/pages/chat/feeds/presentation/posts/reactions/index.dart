import 'package:flutter/material.dart';
import '../../../export.dart';

class ReactionsScreen extends StatelessWidget {
  final List<String> likesId;

  const ReactionsScreen({Key key, this.likesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Likes',
          style: theme.textTheme.headline6,
        ),
      ),
      body: UserList(usersId: likesId),
    );
  }
}
