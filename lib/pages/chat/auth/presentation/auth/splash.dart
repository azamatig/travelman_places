import 'package:flutter/material.dart';

import '../../export.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Center(
            child: Image.asset(
              AssetsHelper.SPLASH,
              height: 200,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 150,
            child: LinearProgressIndicator(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
