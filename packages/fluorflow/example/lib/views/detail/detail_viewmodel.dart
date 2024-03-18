import 'dart:async';

import 'package:example/app.bottom_sheets.dart';
import 'package:fluorflow/fluorflow.dart';

final class DetailViewModel extends DataViewModel<int> {
  final _navService = locator<NavigationService>();
  final _sheets = locator<BottomSheetService>();

  DetailViewModel() : super(0);

  void showBottomSheet() =>
      _sheets.showGreetingBottomSheet(callback: () {}, onElement: (_) {});

  void back() => _navService.back();

  void addOne() => data += 1;
}
