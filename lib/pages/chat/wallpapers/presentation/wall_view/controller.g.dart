// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WallpaperPageController on _WallpaperPageController, Store {
  Computed<List<WallpaperModel>> _$wallsComputed;

  @override
  List<WallpaperModel> get walls =>
      (_$wallsComputed ??= Computed<List<WallpaperModel>>(() => super.walls,
              name: '_WallpaperPageController.walls'))
          .value;
  Computed<WallpaperModel> _$currentWallpaperComputed;

  @override
  WallpaperModel get currentWallpaper => (_$currentWallpaperComputed ??=
          Computed<WallpaperModel>(() => super.currentWallpaper,
              name: '_WallpaperPageController.currentWallpaper'))
      .value;
  Computed<int> _$wallsOffsetComputed;

  @override
  int get wallsOffset =>
      (_$wallsOffsetComputed ??= Computed<int>(() => super.wallsOffset,
              name: '_WallpaperPageController.wallsOffset'))
          .value;

  final _$wallIndexAtom = Atom(name: '_WallpaperPageController.wallIndex');

  @override
  int get wallIndex {
    _$wallIndexAtom.reportRead();
    return super.wallIndex;
  }

  @override
  set wallIndex(int value) {
    _$wallIndexAtom.reportWrite(value, super.wallIndex, () {
      super.wallIndex = value;
    });
  }

  final _$doesLikeItAtom = Atom(name: '_WallpaperPageController.doesLikeIt');

  @override
  bool get doesLikeIt {
    _$doesLikeItAtom.reportRead();
    return super.doesLikeIt;
  }

  @override
  set doesLikeIt(bool value) {
    _$doesLikeItAtom.reportWrite(value, super.doesLikeIt, () {
      super.doesLikeIt = value;
    });
  }

  final _$addOrRemoveReactionAsyncAction =
      AsyncAction('_WallpaperPageController.addOrRemoveReaction');

  @override
  Future<void> addOrRemoveReaction() {
    return _$addOrRemoveReactionAsyncAction
        .run(() => super.addOrRemoveReaction());
  }

  final _$downloadWallAsyncAction =
      AsyncAction('_WallpaperPageController.downloadWall');

  @override
  Future<void> downloadWall() {
    return _$downloadWallAsyncAction.run(() => super.downloadWall());
  }

  @override
  String toString() {
    return '''
wallIndex: ${wallIndex},
doesLikeIt: ${doesLikeIt},
walls: ${walls},
currentWallpaper: ${currentWallpaper},
wallsOffset: ${wallsOffset}
    ''';
  }
}
