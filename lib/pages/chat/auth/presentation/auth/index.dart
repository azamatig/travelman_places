import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../export.dart';
import '../login/index.dart';
import 'controller.dart';
import 'splash.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ModularState<AuthScreen, AuthController>
    with WidgetsBindingObserver {
  @override
  void initState() {
    controller.addEvent(AuthEvent.appStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.authState.when<Widget>(
        initial: () => SplashPage(),
        authenticated: () => HomeScreen(),
        unauthenticated: () => LoginScreen(),
      ),
    );
  }
}
