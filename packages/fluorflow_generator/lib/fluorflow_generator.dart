import 'package:build/build.dart';

import 'src/builder/bottom_sheet_builder.dart';
import 'src/builder/dialog_builder.dart';
import 'src/builder/locator_builder.dart';
import 'src/builder/router_builder.dart';
import 'src/builder/test_locator_builder.dart';

Builder locatorBuilder(BuilderOptions options) => LocatorBuilder(options);

Builder testLocatorBuilder(BuilderOptions options) =>
    TestLocatorBuilder(options);

Builder routerBuilder(BuilderOptions options) => RouterBuilder(options);

Builder dialogBuilder(BuilderOptions options) => DialogBuilder(options);

Builder bottomSheetBuilder(BuilderOptions options) =>
    BottomSheetBuilder(options);
