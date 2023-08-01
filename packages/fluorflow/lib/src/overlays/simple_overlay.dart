import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'noop_viewmodel.dart';
import 'overlay.dart';

/// Simple version of the [FluorFlowOverlay] that does not require a view model.
/// The view model of the UI is defaulted to the [NoopViewModel].
abstract base class FluorFlowSimpleOverlay<TResult>
    extends FluorFlowOverlay<TResult, NoopViewModel> {
  const FluorFlowSimpleOverlay({super.key, required super.completer});

  @override
  @nonVirtual
  NoopViewModel viewModelBuilder(BuildContext context) => NoopViewModel();

  @override
  @nonVirtual
  Widget builder(
          BuildContext context, NoopViewModel viewModel, Widget? child) =>
      child!;

  @override
  @nonVirtual
  Widget? staticChildBuilder(BuildContext context) => build(context);

  @override
  @nonVirtual
  void onViewModelCreated(NoopViewModel viewModel) {}

  @protected
  Widget build(BuildContext context);
}
