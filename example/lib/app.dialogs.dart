// ignore_for_file: type=lint

import 'package:example/dialogs/params.dart';
import 'package:example/dialogs/thevoid.dart';
import 'package:fluorflow/fluorflow.dart';

import 'dialogs/simple.dart';

extension Dialogs on DialogService {
  Future<(bool?, dynamic)> showSimpleDialog() => showDialog<(bool?, dynamic)>(
      dialogBuilder: NoTransitionPageRouteBuilder(
          pageBuilder: (context, _, __) => SearchFilterDialog(
                completer: closeDialog,
              ))).then((r) => (r?.$1, r?.$2));

  Future<(bool?, void)> showVoidDialog() => showDialog<(bool?, void)>(
      dialogBuilder: NoTransitionPageRouteBuilder(
          pageBuilder: (context, _, __) => VoidDialog(
                completer: closeDialog,
              ))).then((r) => (r?.$1, null));

  Future<(bool?, String?)> showParamDialog({
    required String name,
  }) =>
      showDialog<(bool?, String?)>(
          dialogBuilder: NoTransitionPageRouteBuilder(
              pageBuilder: (context, _, __) => ParamDialog(
                    name,
                    completer: closeDialog,
                  ))).then((r) => (r?.$1, r?.$2));
}
