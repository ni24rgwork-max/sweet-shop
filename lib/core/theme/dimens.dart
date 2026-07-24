class Dimens {
  // Base dimension value used to calculate other dimensions.
  static const double base = 8.0;

  // Small padding, half of the base value.
  static const double smallPadding = base / 2;

  // Standard padding, equal to the base value.
  static const double padding = base;

  // Medium padding, 1.5 times the base value.
  static const double mediumPadding = base * 1.5;

  // Large padding, twice the base value.
  static const double largePadding = base * 2;

  // Very large padding, three times the base value.
  static const double veryLargePadding = base * 3;

  // Extra large padding, four times the base value.
  static const double extraLargePadding = base * 4;

  // Horizontal screen gutter. Expressive layouts breathe more than baseline
  // M3, so content sits further from the edge than the old 8pt.
  static const double gutter = base * 2.5;

  // Corner radius for rounded corners. Retuned to the expressive shape scale —
  // see AppShapes, which is the source of truth for shape.
  static const double corners = base * 3.5;

  // Small corner radius, for chips and inputs.
  static const double smallCorners = base * 2;

  // Breakpoint for very small devices (e.g., small smartphones).
  static const double verySmallDeviceBreakPoint = 376.0;

  // Breakpoint for small devices (e.g., larger smartphones).
  static const double smallDeviceBreakPoint = 576.0;

  // Breakpoint for medium devices (e.g., tablets).
  static const double mediumDeviceBreakPoint = 768.0;

  // Breakpoint for large devices (e.g., small desktops).
  static const double largeDeviceBreakPoint = 992.0;

  // Breakpoint for extra large devices (e.g., large desktops).
  static const double xlargeDeviceBreakPoint = 1200.0;
}
