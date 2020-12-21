// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WallpapersController on _WallpapersController, Store {
  final _$showAddIconAtom = Atom(name: '_WallpapersController.showAddIcon');

  @override
  bool get showAddIcon {
    _$showAddIconAtom.reportRead();
    return super.showAddIcon;
  }

  @override
  set showAddIcon(bool value) {
    _$showAddIconAtom.reportWrite(value, super.showAddIcon, () {
      super.showAddIcon = value;
    });
  }

  final _$queryAtom = Atom(name: '_WallpapersController.query');

  @override
  WallpapersQuery get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(WallpapersQuery value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$wallsOffsetAtom = Atom(name: '_WallpapersController.wallsOffset');

  @override
  int get wallsOffset {
    _$wallsOffsetAtom.reportRead();
    return super.wallsOffset;
  }

  @override
  set wallsOffset(int value) {
    _$wallsOffsetAtom.reportWrite(value, super.wallsOffset, () {
      super.wallsOffset = value;
    });
  }

  final _$_WallpapersControllerActionController =
      ActionController(name: '_WallpapersController');

  @override
  void scrollListener() {
    final _$actionInfo = _$_WallpapersControllerActionController.startAction(
        name: '_WallpapersController.scrollListener');
    try {
      return super.scrollListener();
    } finally {
      _$_WallpapersControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onRefreshLoading() {
    final _$actionInfo = _$_WallpapersControllerActionController.startAction(
        name: '_WallpapersController.onRefreshLoading');
    try {
      return super.onRefreshLoading();
    } finally {
      _$_WallpapersControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showAddIcon: ${showAddIcon},
query: ${query},
wallsOffset: ${wallsOffset}
    ''';
  }
}
