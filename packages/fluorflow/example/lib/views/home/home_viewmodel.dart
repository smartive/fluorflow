import 'package:fluorflow/fluorflow.dart';

import '../../app.dialogs.dart';
import '../../app.router.dart';

final class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  var _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void showTestDialog() => _dialogService.showRedDialog(elements: []);

  void showSmallDialog() => _dialogService.showSmallDialog();

  void goToDetail() => _navService.navigateToDetailView();
}
