// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterController, Store {
  final _$photoFileAtom = Atom(name: '_RegisterController.photoFile');

  @override
  File get photoFile {
    _$photoFileAtom.reportRead();
    return super.photoFile;
  }

  @override
  set photoFile(File value) {
    _$photoFileAtom.reportWrite(value, super.photoFile, () {
      super.photoFile = value;
    });
  }

  final _$genderAtom = Atom(name: '_RegisterController.gender');

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  final _$isRegisteringAtom = Atom(name: '_RegisterController.isRegistering');

  @override
  bool get isRegistering {
    _$isRegisteringAtom.reportRead();
    return super.isRegistering;
  }

  @override
  set isRegistering(bool value) {
    _$isRegisteringAtom.reportWrite(value, super.isRegistering, () {
      super.isRegistering = value;
    });
  }

  final _$hasAcceptedTermAndConditionsAtom =
      Atom(name: '_RegisterController.hasAcceptedTermAndConditions');

  @override
  bool get hasAcceptedTermAndConditions {
    _$hasAcceptedTermAndConditionsAtom.reportRead();
    return super.hasAcceptedTermAndConditions;
  }

  @override
  set hasAcceptedTermAndConditions(bool value) {
    _$hasAcceptedTermAndConditionsAtom
        .reportWrite(value, super.hasAcceptedTermAndConditions, () {
      super.hasAcceptedTermAndConditions = value;
    });
  }

  final _$registerUserAsyncAction =
      AsyncAction('_RegisterController.registerUser');

  @override
  Future<void> registerUser() {
    return _$registerUserAsyncAction.run(() => super.registerUser());
  }

  final _$pickPhotoAsyncAction = AsyncAction('_RegisterController.pickPhoto');

  @override
  Future<void> pickPhoto() {
    return _$pickPhotoAsyncAction.run(() => super.pickPhoto());
  }

  @override
  String toString() {
    return '''
photoFile: ${photoFile},
gender: ${gender},
isRegistering: ${isRegistering},
hasAcceptedTermAndConditions: ${hasAcceptedTermAndConditions}
    ''';
  }
}
