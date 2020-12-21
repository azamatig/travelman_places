import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;

import 'export.dart';
import 'presentation/login/otp_verification.dart';
import 'presentation/profile/current_user/edit_profile_screen.dart';
import 'presentation/register/index.dart';

class AuthModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => AuthRepoImp()),
        m.Bind((i) => UserRepoImp()),
        m.Bind((i) => AuthController()),
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter(m.Modular.initialRoute,
            child: (_, args) => AuthScreen()),
        m.ModularRouter(LOGIN, child: (_, args) => LoginScreen()),
        m.ModularRouter(PROFILE, child: (_, args) => ProfileScreen()),
        m.ModularRouter(
          '$PROFILE/:id',
          child: (_, args) => OtherUserProfile(args.params['id']),
        ),
      ];

  static const LOGIN = '/login', PROFILE = '/profile';
  static Future toMyProfile() => m.Modular.to.pushNamed(PROFILE);

  static Future toOtherUserProfile(String id) =>
      m.Modular.to.pushNamedAndRemoveUntil('$PROFILE${'/$id'}', (route) {
        return !(route.settings.name ?? '').startsWith(PROFILE);
      });

  static Future toOtpVerification() => _to(OtpVerificationScreen());
  static Future toRegister() => _to(RegisterScreen());
  static Future toEditProfile() => _to(EditProfileScreen());

  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
