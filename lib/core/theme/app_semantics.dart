import 'package:flutter/material.dart';

/// The few colour roles Material 3 has no slot for.
///
/// Everything that maps onto [ColorScheme] lives there instead — this extension
/// is deliberately small. It replaces the previous 43-field `AppColors`
/// extension, which duplicated most of what the scheme already provides.
@immutable
class AppSemantics extends ThemeExtension<AppSemantics> {
  const AppSemantics({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.priceAccent,
    required this.rating,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;

  final Color warning;
  final Color onWarning;
  final Color warningContainer;

  /// Used for prices, so money reads as money rather than as body copy.
  final Color priceAccent;

  /// Star ratings.
  final Color rating;

  static const AppSemantics light = AppSemantics(
    success: Color(0xFF3A6B4A),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFCDEBD5),
    warning: Color(0xFF8A5A1B),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFE2BE),
    priceAccent: Color(0xFF7A5732),
    rating: Color(0xFFD79A21),
  );

  static const AppSemantics dark = AppSemantics(
    success: Color(0xFF9FD3AC),
    onSuccess: Color(0xFF0B2715),
    successContainer: Color(0xFF23492F),
    warning: Color(0xFFF2C07B),
    onWarning: Color(0xFF3F2A08),
    warningContainer: Color(0xFF5E3F13),
    priceAccent: Color(0xFFE2BE95),
    rating: Color(0xFFF0C04E),
  );

  @override
  AppSemantics copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? priceAccent,
    Color? rating,
  }) {
    return AppSemantics(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      priceAccent: priceAccent ?? this.priceAccent,
      rating: rating ?? this.rating,
    );
  }

  @override
  AppSemantics lerp(ThemeExtension<AppSemantics>? other, double t) {
    if (other is! AppSemantics) return this;
    return AppSemantics(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      priceAccent: Color.lerp(priceAccent, other.priceAccent, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
    );
  }
}
