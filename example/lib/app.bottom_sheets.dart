// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:example/bottom_sheets/greeting_bottom_sheet.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

extension BottomSheets on _i1.BottomSheetService {
  Future<(bool?, void)> showGreetingBottomSheet({
    _i2.Color barrierColor = const _i2.Color(0x80000000),
    bool fullscreen = false,
    bool draggable = true,
  }) =>
      showBottomSheet<(bool?, void), _i3.GreetingBottomSheet>(
        _i3.GreetingBottomSheet(completer: closeSheet),
        barrierColor: barrierColor,
        fullscreen: fullscreen,
        draggable: draggable,
      ).then((r) => (r?.$1, null));
}
