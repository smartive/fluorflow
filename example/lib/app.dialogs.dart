// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i2;

import 'package:example/dialogs/red_dialog.dart' as _i3;
import 'package:fluorflow/fluorflow.dart' as _i1;

typedef RedDialogResult = (bool?, void);

extension Dialogs on _i1.DialogService {
  Future<RedDialogResult> showRedDialog(
          {_i2.Color barrierColor = const _i2.Color(0x80000000)}) =>
      showDialog<RedDialogResult>(
        barrierColor: barrierColor,
        dialogBuilder: _i1.FadeInPageRouteBuilder(
            pageBuilder: (
          _,
          __,
          ___,
        ) =>
                _i3.RedDialog(completer: closeDialog)),
      ).then((r) => (r?.$1, null));
}
