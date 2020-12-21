// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$isDarkModeAtom = Atom(name: '_AppStore.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$drawerStateAtom = Atom(name: '_AppStore.drawerState');

  @override
  DrawerState get drawerState {
    _$drawerStateAtom.reportRead();
    return super.drawerState;
  }

  @override
  set drawerState(DrawerState value) {
    _$drawerStateAtom.reportWrite(value, super.drawerState, () {
      super.drawerState = value;
    });
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setDarkMode() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setDarkMode');
    try {
      return super.setDarkMode();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
drawerState: ${drawerState}
    ''';
  }
}
