import 'package:get_it/get_it.dart';

// Navigation
export 'src/navigation/navigation_service.dart';
export 'src/navigation/route_factory.dart';
export 'src/navigation/page_route_builder.dart';
// UI
export 'src/viewmodels/base_viewmodel.dart';
export 'src/viewmodels/state_viewmodel.dart';
export 'src/views/fluorflow_view.dart';

// Dependency Injection
typedef Locator = GetIt;
final locator = GetIt.instance;
