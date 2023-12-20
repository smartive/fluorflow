import 'package:fluorflow/fluorflow.dart';

import '../../bottom_sheets/greeting_bottom_sheet.dart';

final class DetailViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _svc = BottomSheetService();

  void showBottomSheet() =>
      _svc.showBottomSheet(GreetingBottomSheet(completer: _svc.closeSheet));

  void back() => _navService.back();
}
