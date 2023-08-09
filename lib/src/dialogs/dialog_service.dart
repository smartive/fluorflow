import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DialogService {
  bool get isDialogOpen => Get.isDialogOpen ?? false;

  Future<TResult?> showDialog<TResult>({
    required PageRouteBuilder dialogBuilder,
    Color barrierColor = const Color(0x80000000),
  }) =>
      Get.generalDialog<TResult>(
        pageBuilder: dialogBuilder.pageBuilder,
        barrierColor: barrierColor,
        transitionDuration: dialogBuilder.transitionDuration,
        routeSettings: dialogBuilder.settings,
        transitionBuilder: dialogBuilder.transitionsBuilder,
      );

  void closeDialog<T>({bool? confirmed, T? result}) =>
      Get.back(result: (confirmed, result));
}
