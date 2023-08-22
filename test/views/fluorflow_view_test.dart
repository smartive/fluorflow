import 'package:fluorflow/src/viewmodels/viewmodel.dart';
import 'package:fluorflow/src/views/fluorflow_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fluorflow_view_test.mocks.dart';

final class TestView extends FluorFlowView<MockViewModel> {
  final MockViewModel vm;

  const TestView(this.vm, {super.key});

  @override
  Widget builder(
          BuildContext context, MockViewModel viewModel, Widget? child) =>
      const Placeholder();

  @override
  MockViewModel viewModelBuilder(BuildContext context) => vm;
}

@GenerateNiceMocks([MockSpec<ViewModel>()])
void main() {
  group('FluorFlowView<TViewModel>', () {
    testWidgets('should initialize viewmodel.', (tester) async {
      final vm = MockViewModel();

      await tester.pumpWidget(TestView(vm));
      await tester.pumpAndSettle();

      verify(vm.initialize()).called(1);
    });
  });
}
