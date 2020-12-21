import 'package:flutter/material.dart';

import '../module.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Reported Posts'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: AdminModule.toReportedPosts,
          ),
        ],
      ),
    );
  }
}
