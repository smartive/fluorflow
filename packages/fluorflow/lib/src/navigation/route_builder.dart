/// Enum representing different types of route builders for navigation transitions.
enum RouteBuilder {
  /// No transition.
  noTransition,

  /// Platform default transition.
  /// For iOS / macOS devices, this uses the cuperino transition which supports
  /// the swipe back gesture. All other devices use the fade upwards transition.
  platform,

  /// Fade in transition.
  fadeIn,

  /// Left to right fade transition.
  leftToRightFade,

  /// Right to left fade transition.
  rightToLeftFade,

  /// Top to bottom fade transition.
  topToBottomFade,

  /// Bottom to top fade transition.
  bottomToTopFade,

  /// Left to right transition.
  leftToRight,

  /// Right to left transition.
  rightToLeft,

  /// Top to bottom transition.
  topToBottom,

  /// Bottom to top transition.
  bottomToTop,

  /// Zoom in transition.
  zoomIn,
}
