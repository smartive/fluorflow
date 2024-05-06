import 'package:fluorflow/fluorflow.dart';

import '../../app.dialogs.dart';
import '../../app.router.dart';

final class HomeViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  var _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void showTestDialog() => _navService.showRedDialog(elements: []);

  void showSmallDialog() => _navService.showSmallDialog();

  void goToDetail() => _navService.navigateToDetailView();
}
