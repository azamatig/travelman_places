import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../export.dart';
import '../profile/widgets/profile_avatar.dart';
import '../widgets/login_button.dart';
import 'controller.dart';

class RegisterScreen extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((_) => RegisterController())];

  @override
  Widget get view => _RegisterScreen();
}

class _RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends ModularState<_RegisterScreen, RegisterController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Text(t.Auth.register),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Observer(
                builder: (_) => ProfileAvatarWidget(
                  photoUrl: '',
                  photoFile: controller.photoFile,
                  editable: true,
                  onTap: controller.pickPhoto,
                ),
              ),
              SizedBox(height: 20),
              CustomTextForm(
                label: t.Auth.name,
                icon: Icons.person_outline,
                controller: controller.usernameController,
                maxLength: 15,
                borderRadius: 20,
                validator: (str) => str.length < 3 && str.isNotEmpty
                    ? t.Auth.add_valid_name
                    : null,
              ),
              CustomTextForm(
                label: t.Auth.status,
                icon: Icons.book,
                controller: controller.statusController,
                maxLength: 20,
                borderRadius: 20,
              ),
              CustomTextForm(
                label: t.Auth.email,
                icon: Icons.email,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                borderRadius: 20,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment(-0.8, 0),
                child: Text(t.Auth.male_gender),
              ),
              Observer(
                builder: (_) => Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(t.Auth.male_gender),
                      value: 'male',
                      groupValue: controller.gender,
                      onChanged: (v) {
                        controller.gender = v;
                      },
                    ),
                    RadioListTile(
                      title: Text(t.Auth.female_gender),
                      value: 'female',
                      groupValue: controller.gender,
                      onChanged: (v) {
                        controller.gender = v;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Observer(
                  builder: (_) => Checkbox(
                    activeColor: theme.accentColor,
                    value: controller.hasAcceptedTermAndConditions,
                    onChanged: (value) {
                      controller.hasAcceptedTermAndConditions =
                          !controller.hasAcceptedTermAndConditions;
                    },
                  ),
                ),
                title: Text(
                  t.Auth.accept_terms,
                  style: theme.textTheme.headline6.copyWith(
                      fontSize: 14, decoration: TextDecoration.underline),
                ),
                onTap: () => launchUrl(Constants.PRIVACY_URL),
              ),
              SizedBox(height: 10),
              Observer(
                builder: (_) => LoginButton(
                  t.Auth.save,
                  isLoading: controller.isRegistering,
                  onTap: controller.registerUser,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
