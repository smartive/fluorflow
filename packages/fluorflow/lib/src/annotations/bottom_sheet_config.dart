/// Configuration options for a bottom sheet.
///
/// It specifies the default barrier color, fullscreen mode, and draggable behavior.
class BottomSheetConfig {
  /// The default color of the barrier that appears behind the bottom sheet.
  /// This is a 32 bit integer value in the format of 0xAARRGGBB.
  final int defaultBarrierColor;

  /// Whether the bottom sheet should be displayed in fullscreen mode.
  /// If set to true, the bottom sheet will take up the entire screen.
  /// If set to false, the bottom sheet will be displayed at the bottom third(-ish) of the screen.
  final bool defaultFullscreen;

  /// Whether the bottom sheet can be dragged by the user.
  final bool defaultDraggable;

  /// Decorate a bottom sheet or simple bottomsheet with a [BottomSheetConfig].
  const BottomSheetConfig({
    this.defaultBarrierColor = 0x80000000,
    this.defaultFullscreen = false,
    this.defaultDraggable = true,
  });
}
