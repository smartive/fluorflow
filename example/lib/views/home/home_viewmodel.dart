import 'package:fluorflow/fluorflow.dart';

class HomeViewModel extends BaseViewModel {
  var _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
