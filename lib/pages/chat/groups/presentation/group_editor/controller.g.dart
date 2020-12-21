// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GroupEditorController on _GroupEditorController, Store {
  final _$photoUrlAtom = Atom(name: '_GroupEditorController.photoUrl');

  @override
  String get photoUrl {
    _$photoUrlAtom.reportRead();
    return super.photoUrl;
  }

  @override
  set photoUrl(String value) {
    _$photoUrlAtom.reportWrite(value, super.photoUrl, () {
      super.photoUrl = value;
    });
  }

  final _$imageFileToUploadAtom =
      Atom(name: '_GroupEditorController.imageFileToUpload');

  @override
  File get imageFileToUpload {
    _$imageFileToUploadAtom.reportRead();
    return super.imageFileToUpload;
  }

  @override
  set imageFileToUpload(File value) {
    _$imageFileToUploadAtom.reportWrite(value, super.imageFileToUpload, () {
      super.imageFileToUpload = value;
    });
  }

  final _$isImageUploadingAtom =
      Atom(name: '_GroupEditorController.isImageUploading');

  @override
  bool get isImageUploading {
    _$isImageUploadingAtom.reportRead();
    return super.isImageUploading;
  }

  @override
  set isImageUploading(bool value) {
    _$isImageUploadingAtom.reportWrite(value, super.isImageUploading, () {
      super.isImageUploading = value;
    });
  }

  final _$createOrEditGroupAsyncAction =
      AsyncAction('_GroupEditorController.createOrEditGroup');

  @override
  Future<void> createOrEditGroup(String name) {
    return _$createOrEditGroupAsyncAction
        .run(() => super.createOrEditGroup(name));
  }

  @override
  String toString() {
    return '''
photoUrl: ${photoUrl},
imageFileToUpload: ${imageFileToUpload},
isImageUploading: ${isImageUploading}
    ''';
  }
}
