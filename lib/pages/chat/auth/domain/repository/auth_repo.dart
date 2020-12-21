import 'package:firebase_auth/firebase_auth.dart';

import '../../export.dart';

abstract class AuthRepository {
  Future<String> getTokenOrUid();

  Future<String> emailLogin(String email, String password);

  Future<void> verifyPhone(
    String phoneNumber,
    void Function(String) onCodeSent,
    void Function(AuthCredential phoneAuthCredential) onComplete,
    void Function(CustomAuthException e) onFailed,
  );

  Future<String> phoneLogin(String verificationId, String smsCode);

  Future<void> logOut();

  CustomAuthException handleAuthException(e);
}
