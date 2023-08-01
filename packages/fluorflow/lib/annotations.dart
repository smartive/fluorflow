/// This library contains all annotations that are needed by the `fluorflow_generator`.
/// Refer to the specific annotations for further documentation.
///
/// To use the annotations, install `fluorflow` as a dependency and `fluorflow_generator`
/// as a dev_dependency. When done, you want to have `build_runner` as a dev dependency too.
///
/// When running the build runner, the dependencies and configurations are used to
/// generate dart code.
///
/// Note: when the build_runner / fluorflow_generator is not used, the annotations are
/// not needed and have no effect.
library annotations;

export 'src/annotations/bottom_sheet_config.dart';
export 'src/annotations/dialog_config.dart';
export 'src/annotations/injectable.dart';
export 'src/annotations/routable.dart';
export 'src/navigation/route_builder.dart';
