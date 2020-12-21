import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../export.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final authController = Modular.get<AuthController>();
  User get currentUser => authController.currentUser;

  bool isChanged = false;
  @override
  void dispose() {
    if (isChanged) {
      authController.userRepo.updateUseInfo(currentUser);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.Settings.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Observer(
              builder: (_) => SettingsSection(
                title: t.Settings.account,
                tiles: [
                  SettingsTile(
                    title: t.Settings.edit_profile,
                    leading: Icon(Icons.person),
                    onTap: AuthModule.toEditProfile,
                  ),
                  SettingsTile.switchTile(
                    title: t.Settings.online_status,
                    subtitle: t.Settings.online_description,
                    leading: Icon(currentUser.onlineStatus
                        ? Icons.visibility
                        : Icons.visibility_off),
                    switchValue: currentUser.onlineStatus,
                    onToggle: (v) {
                      currentUser.onlineStatus = v;
                      isChanged = true;
                    },
                  ),
                  SettingsTile(
                    title: t.Settings.logout,
                    leading: Icon(FontAwesomeIcons.powerOff),
                    onTap: () async {
                      BotToast.showLoading(
                          backgroundColor: Colors.grey.withAlpha(120));
                      if (isChanged) {
                        isChanged = false;
                        await authController.userRepo
                            .updateUseInfo(currentUser);
                      }
                      await Modular.to.pop();
                      await Modular.get<AuthController>()
                          .addEvent(AuthEvent.logout());
                      BotToast.closeAllLoading();
                    },
                  ),
                ],
              ),
            ),
            Observer(
              builder: (_) => SettingsSection(
                title: t.Settings.notifications,
                tiles: [
                  SettingsTile.switchTile(
                    title: t.Settings.direct_msgs,
                    subtitle: t.Settings.direct_msgs_descr,
                    leading: Icon(
                      currentUser.chatNotify
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                    ),
                    switchValue: currentUser.chatNotify,
                    onToggle: (v) {
                      currentUser.chatNotify = v;
                      isChanged = true;
                    },
                  ),
                  SettingsTile.switchTile(
                    title: t.Settings.groups_msgs,
                    subtitle: t.Settings.groups_msgs_desc,
                    leading: Icon(
                      currentUser.groupsNotify
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                    ),
                    switchValue: currentUser.groupsNotify,
                    onToggle: (v) {
                      currentUser.groupsNotify = v;
                      isChanged = true;
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(t.Settings.about),
              leading: Icon(Icons.help_outline),
              onTap: AppModule.toAbout,
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
