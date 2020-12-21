import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../export.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final controller = Modular.get<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.setUserOnline(false);
    } else if (state == AppLifecycleState.resumed) {
      controller.setUserOnline(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    RateAppHelper.init(context);
    return FeedScreen();
  }
}
