import 'package:flutter/widgets.dart';

/// Screen-metric shorthands for the few places that need raw dimensions.
///
/// Uses `MediaQuery.sizeOf` rather than `MediaQuery.of` so a size change only
/// rebuilds widgets depending on the size aspect, not every dependent of the
/// whole MediaQuery.
extension ScreenMetrics on BuildContext {
  /// Logical pixel size of the window.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Window width in logical pixels.
  double get widthPx => screenSize.width;

  /// Window height in logical pixels.
  double get heightPx => screenSize.height;
}
