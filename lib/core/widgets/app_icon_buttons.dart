import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Circular filled icon button — quantity steppers, add-to-cart, overlay actions.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 40,
  });

  final IconData icon;
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
        icon: Icon(
          icon,
          size: size * 0.45,
          color: iconColor ?? colors.onSecondaryContainer,
        ),
      ),
    );
  }
}
