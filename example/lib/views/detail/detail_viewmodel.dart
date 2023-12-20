import 'package:fluorflow/fluorflow.dart';

final class DetailViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  void back() => _navService.back();
}
