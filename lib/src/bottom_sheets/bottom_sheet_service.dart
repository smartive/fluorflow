import 'dart:ui';

import 'package:get/get.dart';

import '../overlays/overlay.dart';

class BottomSheetService {
  bool get isDialogOpen => Get.isBottomSheetOpen ?? false;

  Future<TResult?> showBottomSheet<TResult, TSheet extends FluorFlowOverlay>(
    TSheet sheet, {
    Color barrierColor = const Color(0x80000000),
    bool fullscreen = false,
    bool draggable = true,
  }) =>
      Get.bottomSheet(
        sheet,
        barrierColor: barrierColor,
        isScrollControlled: fullscreen,
        enableDrag: draggable,
      );

  void closeSheet<T>({bool? confirmed, T? result}) =>
      Get.back(result: (confirmed, result));
}
