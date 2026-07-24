import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Type scale for the app.
///
/// Two families, split by role:
///  * **Fraunces** — a variable soft serif — carries display and headline. It
///    gives the big editorial lines character.
///  * **Inter** carries title, body and label, so every control and price stays
///    neutral and legible at small sizes.
///
/// Returns a real [TextTheme] rather than a custom [ThemeExtension] so that
/// `Theme.of(context).textTheme.*` — the idiomatic accessor — works everywhere.
abstract final class AppTypography {
  const AppTypography._();

  static TextStyle _display(double size, {double height = 1.08}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: height,
        letterSpacing: -0.5,
      );

  static TextStyle _ui(
    double size, {
    FontWeight weight = FontWeight.w400,
    double height = 1.35,
    double spacing = 0,
  }) => GoogleFonts.inter(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: spacing,
  );

  static TextTheme textTheme(Color onSurface, Color onSurfaceVariant) {
    final TextTheme base = TextTheme(
      // Display + headline — Fraunces.
      displayLarge: _display(48),
      displayMedium: _display(40),
      displaySmall: _display(36),
      headlineLarge: _display(30, height: 1.15),
      headlineMedium: _display(26, height: 1.18),
      headlineSmall: _display(22, height: 1.2),

      // Title, body, label — Inter.
      titleLarge: _ui(19, weight: FontWeight.w600, height: 1.25),
      titleMedium: _ui(16, weight: FontWeight.w600),
      titleSmall: _ui(14, weight: FontWeight.w600),

      bodyLarge: _ui(15, height: 1.45),
      bodyMedium: _ui(14, height: 1.45),
      bodySmall: _ui(12.5, height: 1.4),

      labelLarge: _ui(14, weight: FontWeight.w600, spacing: 0.1),
      labelMedium: _ui(12, weight: FontWeight.w600, spacing: 0.2),
      labelSmall: _ui(11, weight: FontWeight.w500, spacing: 0.3),
    );

    return base.apply(
      bodyColor: onSurface,
      displayColor: onSurface,
      decorationColor: onSurface,
    );
  }

  /// Tabular, tightly-tracked numerals for prices and totals.
  static TextStyle price(double size, {FontWeight weight = FontWeight.w700}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: -0.4,
        height: 1.15,
        fontFeatures: const [FontFeature.tabularFigures()],
      );
}
