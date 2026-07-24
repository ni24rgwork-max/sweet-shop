import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';

/// Raised surface.
///
/// M3 expresses elevation with tonal colour rather than drop shadows, so this
/// sits on `surfaceContainer` instead of casting the previous 10px black blur.
class ShadedContainer extends StatelessWidget {
  const ShadedContainer({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.constraints,
    this.borderRadius,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      decoration: BoxDecoration(
        color: color ?? context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(borderRadius ?? Dimens.corners),
      ),
      child: child,
    );
  }
}
