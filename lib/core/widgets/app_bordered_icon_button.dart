import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'app_svg_viewer.dart';

/// Circular outlined icon button — back arrows, bookmarks, overflow.
class AppBorderedIconButton extends StatelessWidget {
  const AppBorderedIconButton({
    required this.iconPath,
    super.key,
    this.onPressed,
    this.color,
    this.size = 48,
  });

  final String iconPath;
  final VoidCallback? onPressed;
  final Color? color;
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
          side: BorderSide(color: colors.outlineVariant),
          backgroundColor: colors.surface.withValues(alpha: 0.72),
          padding: EdgeInsets.zero,
        ),
        icon: AppSvgViewer(
          iconPath,
          width: size * 0.42,
          color: color ?? colors.onSurface,
        ),
      ),
    );
  }
}
