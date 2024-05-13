# [3.1.0](https://github.com/smartive/fluorflow/compare/v3.0.1...v3.1.0) (2024-05-13)


### Features

* **navigation:** add platform specific page builder ([#8](https://github.com/smartive/fluorflow/issues/8)) ([03a69bd](https://github.com/smartive/fluorflow/commit/03a69bd384b12529a325722adce37f21aab97104))
* **navigation:** add possibility for config of max history limit ([#7](https://github.com/smartive/fluorflow/issues/7)) ([3349f8d](https://github.com/smartive/fluorflow/commit/3349f8dafbd8296b730cd78ebfc27ae7a1669f0e))
* **navigation:** expose the previous route in navigation service ([#9](https://github.com/smartive/fluorflow/issues/9)) ([087cea6](https://github.com/smartive/fluorflow/commit/087cea635145eefee600ef8375ebe39ce02e4ae3))

## [3.0.1](https://github.com/smartive/fluorflow/compare/v3.0.0...v3.0.1) (2024-05-07)


### Bug Fixes

* **generator:** upgrade fluorflow dep ([c8a7c7f](https://github.com/smartive/fluorflow/commit/c8a7c7f64c1c2fdb965cf187cb2aa7fa84d05c5f))

# [3.0.0](https://github.com/smartive/fluorflow/compare/v2.0.1...v3.0.0) (2024-05-07)


### Features

* use native navigation instead of getX navigation ([#6](https://github.com/smartive/fluorflow/issues/6)) ([e9cf309](https://github.com/smartive/fluorflow/commit/e9cf309a02825c772cba35cd2c5170ba7aa3441e))


### BREAKING CHANGES

* The `DialogService` was deleted.
Dialog related methods are now in the `NavigationService`.
* The `BottomSheetService` was deleted.
All related methods are now in the `NavigationService`.
* the close methods for dialog and
sheet (`closeDialog` and `closeSheet`) are removed. They
are unified in the method `closeOverlay` in the `NavigationService`.
* Since getX is removed, the base logic of
the entry point in the app could be simplified. Instead of
the key and observer being methods, they are now static
initialized fields on the navigation service.

BRAKING CHANGE: The `preventDuplicates` parameter for the
navigation method is gone. Currently, with native
navigation, the user of the package is responsible to
have an overview of the navigation stack.

## [2.0.1](https://github.com/smartive/fluorflow/compare/v2.0.0...v2.0.1) (2024-03-18)


### Bug Fixes

* upgrade generator dependency to fluorflow ([fc8ed7b](https://github.com/smartive/fluorflow/commit/fc8ed7b8971bbeb3bcb2d372f7d3770e1dc92a29))

# [2.0.0](https://github.com/smartive/fluorflow/compare/v1.2.1...v2.0.0) (2024-03-18)


### Features

* simplify data view model ([#5](https://github.com/smartive/fluorflow/issues/5)) ([fad3176](https://github.com/smartive/fluorflow/commit/fad3176a2a8baff45b6d86e4c89ea9d8de1097d2))


### BREAKING CHANGES

* This removes the complex initialization
logic of the `DataViewModel<T>`. Instead of using the
`initializeData` method, now the constructor of the view model
requires some form of initial data. This requires developers to
explicitely define nullable types and allows the `data` field to be
initialized in all cases. To migrate, remove all `initializeData` calls
and provide the constructor with some default data. It is still possible
to load data asynchronously, by overwriting the `initialize` method and
fetching data there. One is responsible to call `super.initialize` in
error cases.
* This simplifies the routable and dialog config by
removing the `RouteBuilder.custom` variant. Basically, to use a custom
page route builder, just use the provided property (`pageRouteBuilder`)
and do not set the `routeBuilder` property. If the page route builder is
provided,
the route builder property is ignored.

## [1.2.1](https://github.com/smartive/fluorflow/compare/v1.2.0...v1.2.1) (2024-03-06)


### Bug Fixes

* allow record types as params and return types ([#4](https://github.com/smartive/fluorflow/issues/4)) ([fc946a5](https://github.com/smartive/fluorflow/commit/fc946a5b576c644c75a6c7c80302cf800b09b8f5))

# [1.2.0](https://github.com/smartive/fluorflow/compare/v1.1.0...v1.2.0) (2024-02-23)


### Features

* allow barrier dismiss in dialogs ([#3](https://github.com/smartive/fluorflow/issues/3)) ([efe034f](https://github.com/smartive/fluorflow/commit/efe034fe18f33174a057e8dc378a0f522a64d407))

# [1.1.0](https://github.com/smartive/fluorflow/compare/v1.0.5...v1.1.0) (2024-02-21)


### Features

* allow safe area configuration for bottom sheets ([#2](https://github.com/smartive/fluorflow/issues/2)) ([ebd2cce](https://github.com/smartive/fluorflow/commit/ebd2ccef94d533c5d12574c3084561e8cab3ddfc))

## [1.0.5](https://github.com/smartive/fluorflow/compare/v1.0.4...v1.0.5) (2024-02-16)


### Bug Fixes

* **generator:** remove flutter dependency ([56558b4](https://github.com/smartive/fluorflow/commit/56558b41a50a0142020d09336f7f940c2c176445))

## [1.0.4](https://github.com/smartive/fluorflow/compare/v1.0.3...v1.0.4) (2024-02-15)


### Bug Fixes

* **fluorflow:** soften dependency requirements ([3d5440c](https://github.com/smartive/fluorflow/commit/3d5440c205404bd36fbe06ed3f769342c2b23031))
* **generator:** add flutter as dependency ([452564f](https://github.com/smartive/fluorflow/commit/452564f626660c0ff4c9f86a35bfee32a4219819))
* **generator:** set base dependencies lower ([f96af64](https://github.com/smartive/fluorflow/commit/f96af6443440296313e5c39aaab8630f83d223e4))

## [1.0.3](https://github.com/smartive/fluorflow/compare/v1.0.2...v1.0.3) (2024-02-15)


### Bug Fixes

* use next major version for generator ([812dd02](https://github.com/smartive/fluorflow/commit/812dd0282cc0aaea10b213bbd527e5c4f4cf5c5b))

## [1.0.2](https://github.com/smartive/fluorflow/compare/v1.0.1...v1.0.2) (2024-02-15)


### Bug Fixes

* **deployment:** fix mapping value in yaml ([c3a3209](https://github.com/smartive/fluorflow/commit/c3a3209b044d3330d97d2e018b690484e5d4a821))
* pubspec yaml is invalid ([b03e78c](https://github.com/smartive/fluorflow/commit/b03e78cb8b93a181c6863f65811699bdacc8f20a))

## [1.0.1](https://github.com/smartive/fluorflow/compare/v1.0.0...v1.0.1) (2024-02-15)


### Bug Fixes

* **generator:** correctly set fluorflow version dependency ([93a833d](https://github.com/smartive/fluorflow/commit/93a833d0a147b765267fd1948e9eed08148db0e9))

# 1.0.0 (2024-02-15)


### Features

* **fluorflow:** initial version of the released framework ([15e8fb0](https://github.com/smartive/fluorflow/commit/15e8fb0bc906c211726e9e89a77380bcbd47b2f8))

# 0.0.0-development
