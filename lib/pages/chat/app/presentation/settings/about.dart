import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../export.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(t.About.title),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              AssetsHelper.APP_ICON,
              height: 200,
            ),
          ),
          SizedBox(height: 10),
          Text(
            t.app_name,
            style: GoogleFonts.cairo(textStyle: theme.textTheme.headline5),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(t.About.about_app),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  AssetsHelper.APP_ICON,
                  height: 80,
                ),
                applicationVersion: t.app_version,
                applicationName: t.app_name,
                applicationLegalese: 'ShrApps',
                useRootNavigator: false,
                children: [
                  Text(t.about_us, textAlign: TextAlign.justify),
                ],
              );
            },
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(t.About.rate_us),
            trailing: Icon(Icons.chevron_right),
            onTap: () => RateAppHelper.showRating(context),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text(t.About.privacy_policy),
            trailing: Icon(Icons.chevron_right),
            onTap: () => launchUrl(Constants.PRIVACY_URL),
          ),
        ],
      ),
    );
  }
}
