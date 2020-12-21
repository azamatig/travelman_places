import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../export.dart';
import '../widgets/login_button.dart';
import 'widgets/phone_form.dart';

class LoginScreen extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((_) => LoginController())];

  @override
  Widget get view => _LoginScreen();
}

class _LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ModularState<_LoginScreen, LoginController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: FocusScope.of(context).unfocus,
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height / 3,
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
              child: SafeArea(
                child: Center(
                  child: Image.asset(
                    AssetsHelper.SPLASH,
                    height: 200,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PhoneFormWidget(),
            ),
            Spacer(flex: 2),
            Observer(
              builder: (_) => LoginButton(
                t.Auth.next,
                isLoading: controller.isLogging,
                onTap: controller.getValidationCode,
              ),
            ),
            Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
