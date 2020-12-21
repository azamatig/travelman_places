import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../export.dart';
import '../widgets/profile_avatar.dart';

class EditProfileScreen extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((_) => UserController())];

  @override
  Widget get view => _EditProfileScreen();
}

class _EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState
    extends ModularState<_EditProfileScreen, UserController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final curretUser = controller.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.Settings.edit_profile),
        centerTitle: true,
      ),
      body: Theme(
        data: AppTheme.darkTheme,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 400,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5.0,
                      color: theme.primaryColorDark,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 60),
                          CustomTextForm(
                            icon: Icons.person_outline,
                            label: t.Auth.name,
                            controller: controller.nameController
                              ..text = curretUser.name,
                            borderRadius: 10,
                            maxLength: 20,
                          ),
                          CustomTextForm(
                            icon: FontAwesomeIcons.adjust,
                            label: t.Auth.status,
                            controller: controller.statusController
                              ..text = curretUser.status,
                            borderRadius: 10,
                            maxLength: 30,
                          ),
                          SizedBox(height: 10),
                          CustomButton(
                            t.Auth.save,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.updateUserInfo();
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Material(
                      elevation: 5.0,
                      shape: CircleBorder(),
                      child: Observer(
                        builder: (_) => ProfileAvatarWidget(
                          photoUrl: controller.currentUser.photoUrl,
                          // isLoading: controller.au is LoadingProfilePic,
                          editable: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
