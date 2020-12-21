import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../export.dart';
import 'controller.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Expanded(
                child: FlareActor(
                  'res/otp.flr',
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  animation: 'otp',
                ),
              ),
              SizedBox(height: 12),
              Text(
                t.Auth.phone_verification,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: t.Auth.enter_code,
                    children: [
                      TextSpan(
                        text: controller.phoneNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                    style: theme.textTheme.subtitle2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  backgroundColor: Colors.transparent,
                  pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                  textStyle: TextStyle(fontSize: 22),
                  onChanged: (value) {
                    controller.smsCode = value;
                  },
                ),
              ),
              Observer(
                builder: (_) => Text(
                  controller.otpErrorMsg,
                  style: TextStyle(
                    color: Colors.red.shade300,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: t.Auth.didnt_recieve_code,
                      style: theme.textTheme.subtitle2,
                    ),
                    TextSpan(
                      text: t.Auth.resend,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      style: TextStyle(
                        color: Color(0xFF91D3B3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: Observer(
                    builder: (_) => CustomButton(
                      t.Auth.verify,
                      isLoading: controller.isLogging,
                      onTap: controller.loginUser,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
