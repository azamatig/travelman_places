import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import '../../export.dart';

class AuthRepoImp implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Future<String> getTokenOrUid() async => _auth.currentUser?.uid;

  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> verifyPhone(
    String phoneNumber,
    void Function(String) onCodeSent,
    void Function(AuthCredential phoneAuthCredential) onComplete,
    void Function(CustomAuthException e) onFailed,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: (verId) {
          //Starts the phone number verification process for the given phone number.
          //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
          // verificationId = verId;
        },
        codeSent: (verId, [forceCodeResend]) {
          onCodeSent(verId);
        },
        timeout: const Duration(seconds: 20),
        verificationCompleted: onComplete,
        verificationFailed: (e) {
          onFailed(handleAuthException(e));
        },
      );
    } catch (e) {
      onFailed(handleAuthException(e));
    }
  }

  @override
  Future<String> phoneLogin(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final fbUser = (await _auth.signInWithCredential(credential)).user;
      if (fbUser.uid == null) {
        throw CustomAuthException('Oops! something went wrong');
      }
      return fbUser.uid;
    } catch (e) {
      throw handleAuthException(e);
    }
  }

  @override
  Future<String> emailLogin(String email, String password) async {
    try {
      final uid = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user
          .uid;
      if (uid == null) throw Exception('no user record');
      return uid;
    } catch (e) {
      throw handleAuthException(e);
    }
  }

  @override
  CustomAuthException handleAuthException(e) {
    String message;
    if (e is FirebaseAuthException) {
      message = e.message;
    } else if (e is PlatformException) {
      if (e.code == 'ERROR_INVALID_VERIFICATION_CODE') {
        message = 'Oops! Vefication Code is wrong';
      } else {
        message = e.message;
      }
    }
    if (message == null) {
      message = 'Oops! Something went wrong, Please Check your network!';
    } else if (message.contains('password is invalid')) {
      message = 'Password Is Invalid';
    } else if (message.contains('no user record')) {
      message = 'User Not Registered, Please Consider Registring First!';
    } else if (message.contains('email address is already')) {
      message = 'Email Address is Already in use by another account';
    }
    Logger().e(message, e);
    return CustomAuthException(message);
  }
}
