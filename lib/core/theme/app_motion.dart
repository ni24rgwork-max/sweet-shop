import 'package:flutter/animation.dart';

/// Motion tokens.
///
/// Material 3 Expressive replaces the old duration+easing pairs with
/// spring-driven motion, split into two families:
///
///  * **spatial** — anything that moves or resizes. Carries a little bounce, so
///    movement feels physical.
///  * **effects** — colour, opacity, elevation. Critically damped: no overshoot,
///    because a colour that overshoots reads as a glitch rather than as motion.
///
/// Flutter stable has no `Curve` implementation backed by a spring, so this
/// exposes both forms: [SpringDescription] tokens for anything driven by an
/// [AnimationController] via `animateWith(SpringSimulation(...))`, and cubic
/// approximations for the implicit animations that only accept a [Curve].
abstract final class AppMotion {
  const AppMotion._();

  // ── Durations ──────────────────────────────────────────────────────────────
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration deliberate = Duration(milliseconds: 700);

  // ── Springs (for AnimationController.animateWith) ──────────────────────────

  /// Movement and resizing. The slight bounce is the point.
  static final SpringDescription spatialFast =
      SpringDescription.withDurationAndBounce(
        duration: fast,
        bounce: 0.2,
      );

  static final SpringDescription spatial =
      SpringDescription.withDurationAndBounce(
        duration: normal,
        bounce: 0.25,
      );

  static final SpringDescription spatialSlow =
      SpringDescription.withDurationAndBounce(
        duration: slow,
        bounce: 0.3,
      );

  /// Colour, opacity, elevation. Zero bounce — critically damped.
  static final SpringDescription effects =
      SpringDescription.withDurationAndBounce(
        duration: fast,
        bounce: 0,
      );

  // ── Curves (for implicit animations) ──────────────────────────────────────

  /// Approximates [spatial]: eases out with a touch of overshoot.
  static const Curve spatialCurve = Cubic(0.24, 1.1, 0.32, 1);

  /// Approximates [spatialSlow] for larger travel.
  static const Curve emphasised = Cubic(0.2, 0.9, 0.1, 1);

  /// Approximates [effects]: no overshoot.
  static const Curve effectsCurve = Cubic(0.3, 0, 0.2, 1);

  /// Entering elements — decelerate in.
  static const Curve enter = Cubic(0.05, 0.7, 0.1, 1);

  /// Leaving elements — accelerate out.
  static const Curve exit = Cubic(0.3, 0, 0.8, 0.15);
}
