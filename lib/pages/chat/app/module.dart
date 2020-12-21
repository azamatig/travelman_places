import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'package:travelman/pages/chat/admin/module.dart';
import 'package:travelman/pages/chat/admin/presentation/index.dart';
import 'package:travelman/pages/chat/common/image_full_view.dart';
import 'package:travelman/pages/chat/core/styles.dart';
import 'package:travelman/pages/chat/module.dart';

import 'export.dart';
import 'presentation/settings/about.dart';

export 'domain/app_store.dart';

class AppModule extends m.MainModule {
  final appStore = AppStore();
  final authModule = AuthModule();
  final feedModule = FeedsModule();
  final chatModule = ChatModule();
  final groupsModule = GroupsModule();
  final notificationModule = NotificationModule();
  final wallpaperModule = WallpaperModule();
  final analytics = FirebaseAnalytics();
  final adminModule = AdminModule();
  @override
  List<m.Bind> get binds => [
        m.Bind((_) => appStore),
        m.Bind((_) => analytics),
        ...authModule.binds,
        ...feedModule.binds,
        ...chatModule.binds,
        ...groupsModule.binds,
        ...notificationModule.binds,
        ...wallpaperModule.binds,
        ...adminModule.binds,
      ];

  @override
  List<m.ModularRouter> get routers => [
        m.ModularRouter('', module: authModule),
        m.ModularRouter('', module: feedModule),
        m.ModularRouter('', module: chatModule),
        m.ModularRouter('', module: groupsModule),
        m.ModularRouter('', module: notificationModule),
        m.ModularRouter('', module: wallpaperModule),
        m.ModularRouter('', module: adminModule),
        m.ModularRouter(SETTINGS, child: (_, args) => SettingsScreen()),
        m.ModularRouter(ABOUT, child: (_, args) => AboutScreen()),
      ];

  @override
  Widget get bootstrap => Observer(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: t.app_name,
          initialRoute: '/',
          onGenerateRoute: m.Modular.generateRoute,
          navigatorKey: m.Modular.navigatorKey,
          builder: BotToastInit(),
          navigatorObservers: [
            BotToastNavigatorObserver(),
            FirebaseAnalyticsObserver(analytics: analytics),
            appStore.routeObserver,
          ],
          themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
          ],
        ),
      );

  static const SETTINGS = '/settings', ABOUT = '/about';
  static Future toSettings() => m.Modular.to.pushNamed(SETTINGS);
  static Future toAbout() => m.Modular.to.pushNamed(ABOUT);
  static Future showFullImage(String url, {bool isLocal}) =>
      _to(ImageFullViewWidget(imgUrl: url, isLocal: isLocal));

  static Future toAdminScreen() => _to(AdminScreen());
  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
