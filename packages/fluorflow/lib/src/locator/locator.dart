import 'package:get_it/get_it.dart';

/// Alias for GetIt. This is the dependency locator (container) for the app.
typedef Locator = GetIt;

/// The global locator instance.
final locator = GetIt.instance;
