import 'dart:math';

import 'package:flutter/widgets.dart';

/// A service for showing and closing dialogs.
/// Works with route builders. However, it is recommended to use the
/// convenience methods generated by the generator to show a dialog.
class DialogService {
  final _random = Random();

  /// Returns whether a dialog is currently open.
  bool get isDialogOpen => false; //Get.isDialogOpen ?? false;

  /// Shows a dialog and returns a future with the (possible) result.
  ///
  /// - The [barrierColor] parameter can be used to specify a custom barrier color for the dialog.
  /// - The [barrierDismissible] parameter specifies whether the dialog can be dismissed by
  ///   tapping the barrier (if it is visible).
  Future<TResult?> showDialog<TResult>({
    required PageRouteBuilder dialogBuilder,
    Color barrierColor = const Color(0x80000000),
    bool barrierDismissible = false,
  }) async {}
  // Get.generalDialog<TResult>(
  //   barrierDismissible: barrierDismissible,
  //   barrierLabel:
  //       barrierDismissible ? 'dialog_${_random.nextInt(1000000)}' : null,
  //   pageBuilder: dialogBuilder.pageBuilder,
  //   barrierColor: barrierColor,
  //   transitionDuration: dialogBuilder.transitionDuration,
  //   routeSettings: dialogBuilder.settings,
  //   transitionBuilder: dialogBuilder.transitionsBuilder,
  // );

  /// Closes the currently open dialog.
  void closeDialog<T>({bool? confirmed, T? result}) {}
  // Get.back(result: (confirmed, result));
}
