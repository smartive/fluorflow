import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:fluorflow_generator/src/builder/bottom_sheet_builder.dart';
import 'package:test/test.dart';

void main() {
  group('BottomSheetBuilder', () {
    test(
        'should not generate something when no input is given.',
        () => testBuilder(BottomSheetBuilder(BuilderOptions.empty), {},
            outputs: {}));

    test(
        'should not generate something when no subclasses for bottom sheets are present.',
        () => testBuilder(BottomSheetBuilder(BuilderOptions.empty), {
              'a|lib/a.dart': '''
                class View {}
              '''
            }, outputs: {}));

    group('for FluorFlowSimpleBottomSheet', () {
      test(
          'should generate sheet method for dynamic return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for void return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<void> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, void)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, void), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, null));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for core return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<String> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, String?)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, String?), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for library return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                import 'b.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<DialogResultType> {
                  const MySheet({super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class DialogResultType {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i3;

import 'package:a/a.dart' as _i4;
import 'package:a/b.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, _i2.DialogResultType?)> showMySheet({
    _i3.Color barrierColor = const _i3.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, _i2.DialogResultType?), _i4.MySheet>(
        _i4.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for FluorFlowBottomSheet', () {
      test(
          'should generate sheet method for dynamic return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowBottomSheet<dynamic, MyViewModel> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for void return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowBottomSheet<void, MyViewModel> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, void)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, void), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, null));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for core return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowBottomSheet<String, MyViewModel> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, String?)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, String?), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method for library return type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                import 'b.dart';

                class MySheet extends FluorFlowBottomSheet<DialogResultType, MyViewModel> {
                  const MySheet({super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class DialogResultType {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i3;

import 'package:a/a.dart' as _i4;
import 'package:a/b.dart' as _i2;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, _i2.DialogResultType?)> showMySheet({
    _i3.Color barrierColor = const _i3.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, _i2.DialogResultType?), _i4.MySheet>(
        _i4.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for Bottom Sheet with parameters', () {
      test(
          'should generate sheet method with required positional argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final String pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required String pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with required nullable positional argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final String? pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required String? pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with required named argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final String pos;
                  const MySheet({required this.pos, super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required String pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          completer: closeOverlay,
          pos: pos,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with an optional named argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final String? pos;
                  const MySheet({this.pos, super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    String? pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          completer: closeOverlay,
          pos: pos,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with a defaulted named argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final String pos;
                  const MySheet({this.pos = 'default', super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    String pos = 'default',
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          completer: closeOverlay,
          pos: pos,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with external referenced argument.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                import 'b.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final MySheetRef pos;
                  const MySheet({required this.pos, super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class MySheetRef {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i4;
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.MySheetRef pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i4.MySheet>(
        _i4.MySheet(
          completer: closeOverlay,
          pos: pos,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for Bottom Sheet with special parameter types', () {
      test(
          'should generate sheet method with generic list of primitive type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final List<String> pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required List<String> pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with generic list of complex type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class Foobar {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final List<Foobar> pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required List<_i3.Foobar> pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with recursive generic type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart';

                class Foo<T> {}
                class Bar<T, T2> {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final Foo<Bar<Baz, int>> pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.Foo<_i3.Bar<_i4.Baz, int>> pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with aliased import type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart' as b;

                class Foo<T> {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final Foo<b.Baz> pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.Foo<_i4.Baz> pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with function type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final void Function() pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required void Function() pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with complex function type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart';

                class Foo {}

                class Bar<T> {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final Foo Function(Bar<Baz> i) pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.Foo Function(_i3.Bar<_i4.Baz>) pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with complex function named parameters type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart';

                class Foo {}

                class Bar<T> {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final Foo Function(Bar<Baz> i, { required Foo f, Baz? b }) pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, {
      required _i3.Foo f,
      _i4.Baz? b,
    }) pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with complex function optional parameters type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart';

                class Foo {}

                class Bar<T> {}

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final Foo Function(Bar<Baz> i, [Foo? f]) pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Baz {}
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:a/b.dart' as _i4;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.Foo Function(
      _i3.Bar<_i4.Baz>, [
      _i3.Foo?,
    ]) pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method with aliased type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';
                import 'b.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  final MyCallback pos;
                  const MySheet(this.pos, {super.key, required this.completer});
                }
              ''',
                'a|lib/b.dart': '''
                class Foobar {}

                typedef MyCallback = void Function(Foobar);
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i4;
import 'package:a/b.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
    required _i3.MyCallback pos,
  }) =>
      showBottomSheet<(bool?, dynamic), _i4.MySheet>(
        _i4.MySheet(
          pos,
          completer: closeOverlay,
        ),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('for Bottom Sheet with special return types', () {
      test(
          'should generate sheet method that returns record type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<(int, int)> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, (int, int)?)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, (int, int)?), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method that returns named record type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<({int a})> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, ({int a})?)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, ({int a})?), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));

      test(
          'should generate sheet method that returns function type.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet<void Function()> {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, void Function()?)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, void Function()?), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with @BottomSheetConfig()', () {
      test(
          'should generate sheet method with custom default options.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions.empty),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/annotations.dart';
                import 'package:fluorflow/fluorflow.dart';

                @BottomSheetConfig(
                  defaultBarrierColor: 0x34ff0000,
                  defaultFullscreen: true,
                  defaultUseSafeArea: false,
                  defaultDraggable: false,
                  defaultShowDragHandle: true,
                )
                class MySheet extends FluorFlowSimpleBottomSheet {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app.bottom_sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x34ff0000),
    bool fullscreen = true,
    bool useSafeArea = false,
    bool draggable = false,
    bool showDragHandle = true,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });

    group('with Builder Configuration', () {
      test(
          'should use custom output if configured.',
          () async => await testBuilder(
              BottomSheetBuilder(BuilderOptions({
                'output': 'lib/app/my.sheets.dart',
              })),
              {
                'a|lib/a.dart': '''
                import 'package:fluorflow/fluorflow.dart';

                class MySheet extends FluorFlowSimpleBottomSheet {
                  const MySheet({super.key, required this.completer});
                }
              '''
              },
              outputs: {
                'a|lib/app/my.sheets.dart': r'''
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:a/a.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.NavigationService {
  Future<(bool?, dynamic)> showMySheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool useSafeArea = false,
    bool draggable = true,
    bool showDragHandle = false,
  }) =>
      showBottomSheet<(bool?, dynamic), _i3.MySheet>(
        _i3.MySheet(completer: closeOverlay),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
      ).then((r) => (r?.$1, r?.$2));
}
'''
              },
              reader: await PackageAssetReader.currentIsolate()));
    });
  });
}
