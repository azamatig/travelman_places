// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginController, Store {
  final _$phoneNumberAtom = Atom(name: '_LoginController.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$countryAtom = Atom(name: '_LoginController.country');

  @override
  Country get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(Country value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
    });
  }

  final _$smsCodeAtom = Atom(name: '_LoginController.smsCode');

  @override
  String get smsCode {
    _$smsCodeAtom.reportRead();
    return super.smsCode;
  }

  @override
  set smsCode(String value) {
    _$smsCodeAtom.reportWrite(value, super.smsCode, () {
      super.smsCode = value;
    });
  }

  final _$verificationIdAtom = Atom(name: '_LoginController.verificationId');

  @override
  String get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  final _$isLoggingAtom = Atom(name: '_LoginController.isLogging');

  @override
  bool get isLogging {
    _$isLoggingAtom.reportRead();
    return super.isLogging;
  }

  @override
  set isLogging(bool value) {
    _$isLoggingAtom.reportWrite(value, super.isLogging, () {
      super.isLogging = value;
    });
  }

  final _$otpErrorMsgAtom = Atom(name: '_LoginController.otpErrorMsg');

  @override
  String get otpErrorMsg {
    _$otpErrorMsgAtom.reportRead();
    return super.otpErrorMsg;
  }

  @override
  set otpErrorMsg(String value) {
    _$otpErrorMsgAtom.reportWrite(value, super.otpErrorMsg, () {
      super.otpErrorMsg = value;
    });
  }

  final _$loginUserAsyncAction = AsyncAction('_LoginController.loginUser');

  @override
  Future<void> loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  final _$getValidationCodeAsyncAction =
      AsyncAction('_LoginController.getValidationCode');

  @override
  Future<void> getValidationCode() {
    return _$getValidationCodeAsyncAction.run(() => super.getValidationCode());
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
country: ${country},
smsCode: ${smsCode},
verificationId: ${verificationId},
isLogging: ${isLogging},
otpErrorMsg: ${otpErrorMsg}
    ''';
  }
}
