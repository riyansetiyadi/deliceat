// Mocks generated by Mockito 5.4.4 from annotations
// in deliceat/test/provider/done_module_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:deliceat/data/db/database_helper.dart'
    as _i2;
import 'package:deliceat/data/model/restaurant.dart'
    as _i5;
import 'package:sqflite/sqflite.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i2.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i3.Future<_i4.Database?>.value(),
      ) as _i3.Future<_i4.Database?>);

  @override
  _i3.Future<void> insertFavorite(_i5.Restaurant? restaurant) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertFavorite,
          [restaurant],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i5.Restaurant>> getFavorites() => (super.noSuchMethod(
        Invocation.method(
          #getFavorites,
          [],
        ),
        returnValue: _i3.Future<List<_i5.Restaurant>>.value(<_i5.Restaurant>[]),
      ) as _i3.Future<List<_i5.Restaurant>>);

  @override
  _i3.Future<Map<dynamic, dynamic>> getFavoriteById(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteById,
          [id],
        ),
        returnValue:
            _i3.Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}),
      ) as _i3.Future<Map<dynamic, dynamic>>);

  @override
  _i3.Future<void> removeFavorite(String? id) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
