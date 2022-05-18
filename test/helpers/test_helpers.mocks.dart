// Mocks generated by Mockito 5.2.0 from annotations
// in flutter_resources/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_resources/domain/entities/app_theme_data.dart' as _i2;
import 'package:flutter_resources/domain/entities/theme_entity.dart' as _i5;
import 'package:flutter_resources/domain/repositories/theme_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAppThemeData_0 extends _i1.Fake implements _i2.AppThemeData {}

/// A class which mocks [ThemeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeRepository extends _i1.Mock implements _i3.ThemeRepository {
  MockThemeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<String>> getSupportedFonts() =>
      (super.noSuchMethod(Invocation.method(#getSupportedFonts, []),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i4.Future<List<String>>);
  @override
  _i4.Future<List<_i5.ColorTheme>> getSupportedThemeColors() =>
      (super.noSuchMethod(Invocation.method(#getSupportedThemeColors, []),
              returnValue:
                  Future<List<_i5.ColorTheme>>.value(<_i5.ColorTheme>[]))
          as _i4.Future<List<_i5.ColorTheme>>);
  @override
  _i4.Future<_i2.AppThemeData> getStoredOrDefaultAppThemeData() => (super
          .noSuchMethod(Invocation.method(#getStoredOrDefaultAppThemeData, []),
              returnValue:
                  Future<_i2.AppThemeData>.value(_FakeAppThemeData_0()))
      as _i4.Future<_i2.AppThemeData>);
  @override
  _i4.Future<void> storeAppThemeData(_i2.AppThemeData? appThemeData) =>
      (super.noSuchMethod(Invocation.method(#storeAppThemeData, [appThemeData]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}
