import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_svg_viewer.dart';

/// Circular filled icon button — quantity steppers, add-to-cart, overlay actions.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.iconPath,
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 40,
  });

  final String iconPath;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SizedBox.square(
      dimension: size,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          shape: AppShapes.pill,
          backgroundColor: backgroundColor ?? colors.secondaryContainer,
          padding: EdgeInsets.zero,
        ),
        icon: AppSvgViewer(
          iconPath,
          width: size * 0.45,
          color: iconColor ?? colors.onSecondaryContainer,
        ),
      ),
    );
  }
}
