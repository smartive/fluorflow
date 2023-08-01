import 'package:example/app.dialogs.dart';
import 'package:example/app.router.dart';
import 'package:fluorflow/fluorflow.dart';

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

  void goToDetail() => _navService.navigateToDetailView();
}
