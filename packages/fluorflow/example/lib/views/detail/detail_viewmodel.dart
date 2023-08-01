import 'package:example/app.bottom_sheets.dart';
import 'package:fluorflow/fluorflow.dart';

final class DetailViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _sheets = locator<BottomSheetService>();

  void showBottomSheet() =>
      _sheets.showGreetingBottomSheet(callback: () {}, onElement: (_) {});

  void back() => _navService.back();
}
