import 'package:flutter/material.dart';

/// Seed-driven colour for the app.
///
/// The palette is "dusty berry & cream": a desaturated berry that keeps the
/// confectionery identity of the brand without the saturated coral the design
/// started from.
///
/// Note the deliberate use of [DynamicSchemeVariant.tonalSpot] rather than
/// [DynamicSchemeVariant.expressive]. The expressive variant intentionally
/// rotates hue and pushes chroma to produce vivid, surprising pairings — the
/// opposite of what this design wants. Expressiveness here comes from shape,
/// motion and type instead, so the colour can stay refined.
abstract final class AppColorScheme {
  const AppColorScheme._();

  /// Muted berry. Everything tonal derives from this single value.
  static const Color seed = Color(0xFFA8536B);

  static final ColorScheme light = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
  ).copyWith(
    // Warm the generated neutrals towards cream. fromSeed derives these from
    // the seed's hue but lands cooler and greyer than a bakery should feel.
    surface: const Color(0xFFFFF8F5),
    surfaceContainerLowest: const Color(0xFFFFFFFF),
    surfaceContainerLow: const Color(0xFFFFF1EC),
    surfaceContainer: const Color(0xFFF7E9E4),
    surfaceContainerHigh: const Color(0xFFF1E1DC),
    surfaceContainerHighest: const Color(0xFFEBDAD4),
    onSurface: const Color(0xFF241619),
  );

  static final ColorScheme dark = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
  ).copyWith(
    surface: const Color(0xFF1A1113),
    surfaceContainerLowest: const Color(0xFF120B0D),
    surfaceContainerLow: const Color(0xFF21171A),
    surfaceContainer: const Color(0xFF271B1E),
    surfaceContainerHigh: const Color(0xFF322528),
    surfaceContainerHighest: const Color(0xFF3E2F33),
    onSurface: const Color(0xFFF0DEE1),
  );
}
