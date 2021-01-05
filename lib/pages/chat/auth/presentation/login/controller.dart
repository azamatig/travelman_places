import 'package:bot_toast/bot_toast.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:mobx/mobx.dart';

import '../../export.dart';

part 'controller.g.dart';

class LoginController extends _LoginController
    with _$LoginController
    implements Disposable {
  @override
  void dispose() {
    super.dispose();
  }
}

abstract class _LoginController with Store {
  final authRepo = Modular.get<AuthRepository>();
  final userRepo = Modular.get<UserRepository>();

  final codeController = TextEditingController(text: '49');
  final phoneController = TextEditingController();

  _LoginController() {
    getInitCode();
  }
  void getInitCode() async {
    try {
      final code = await FlutterSimCountryCode.simCountryCode;
      country = CountryPickerUtils.getCountryByIsoCode(code);
      codeController.text = '${country.phoneCode}';
    } catch (e) {
      print(e);
    }
  }

  @observable
  String phoneNumber;

  @observable
  Country country = CountryPickerUtils.getCountryByPhoneCode('49');

  @observable
  String smsCode = '';

  @observable
  String verificationId;

  @observable
  bool isLogging = false;

  @observable
  String otpErrorMsg = '';

  @action
  Future<void> loginUser() async {
    if (smsCode.length != 6 || int.tryParse(smsCode) == null) {
      otpErrorMsg = t.Auth.invalid_phone;
      return;
    } else {
      otpErrorMsg = '';
    }
    isLogging = true;
    try {
      final uid = await authRepo.phoneLogin(verificationId, smsCode);
      if (await userRepo.checkIfUserExist(uid)) {
        Modular.to.pop();
        await Modular.get<AuthController>().addEvent(AuthEvent.loggedIn(uid));
      } else {
        await Modular.get<AppStore>().pref.setString('Country', country.name);
        await AuthModule.toRegister();
      }
    } on CustomAuthException catch (e, s) {
      otpErrorMsg = e.error;
      BotToast.showText(text: e.error);
      print(s);
    }
    isLogging = false;
  }

  @action
  Future<void> getValidationCode() async {
    isLogging = true;
    phoneNumber = '+${codeController.text}${phoneController.text}';
    try {
      await authRepo.verifyPhone(
        phoneNumber,
        (verId) {
          verificationId = verId;
          isLogging = false;
          AuthModule.toOtpVerification();
        },
        (phoneAuthCredential) {
          print('-----SentCompleted');
        },
        (e) {
          BotToast.showText(text: e.error);
          isLogging = false;
        },
      );
    } on CustomAuthException catch (e) {
      BotToast.showText(text: e.error);
      isLogging = false;
    }
  }

  void dispose() {
    phoneController.dispose();
  }
}
