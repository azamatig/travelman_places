import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_store.g.dart';

const APP_STORE_BOX_NAME = 'app_store';
const DARKMODE_KEY = 'darkmode';
class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final routeObserver = RouteObserver<PageRoute>();
  SharedPreferences pref;
  _AppStore() {
    init();
  }
  void init() async {
    pref = await SharedPreferences.getInstance();
    isDarkMode = pref.getBool(DARKMODE_KEY) ?? true;
  }

  @observable
  bool isDarkMode = true;

  @action
  void setDarkMode() {
    isDarkMode = !isDarkMode;
    pref?.setBool(DARKMODE_KEY, isDarkMode);
  }

  @observable
  var drawerState = DrawerState.GROUPS;
}

enum DrawerState {
  GROUPS,
  FEED,
}
