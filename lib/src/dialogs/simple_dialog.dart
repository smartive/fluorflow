import 'package:flutter/widgets.dart';

import 'completer.dart';

abstract base class FluorFlowSimpleDialog<TResult> extends StatelessWidget {
  final DialogCompleter<TResult> completer;

  const FluorFlowSimpleDialog({super.key, required this.completer});
}
