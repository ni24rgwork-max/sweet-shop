import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';

/// Outlined surface. Defaults to the scheme's `outlineVariant` hairline.
class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    required this.child,
    super.key,
    this.borderColor,
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
  final Color? borderColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final double? borderRadius;

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
        color: color,
        border: Border.all(
          color: borderColor ?? context.colors.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? Dimens.corners),
      ),
      child: child,
    );
  }
}
