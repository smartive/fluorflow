import 'package:fluorflow/annotations.dart';

@LazySingleton()
class DemoService {
  void doSomething() {
    print('Doing something');
  }
}
