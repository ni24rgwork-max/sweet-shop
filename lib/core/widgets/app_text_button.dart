import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'app_svg_viewer.dart';

/// Low-emphasis action — "See all", inline links.
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.onPressed,
    super.key,
    this.title,
    this.child,
    this.color,
    this.iconPath,
  });

  final String? title;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? color;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    final Color foreground = color ?? context.colors.primary;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.mediumPadding,
          vertical: Dimens.padding,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:
          child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: Dimens.smallPadding,
            children: <Widget>[
              Text(title ?? ''),
              if (iconPath != null)
                AppSvgViewer(iconPath!, color: foreground, width: 15),
            ],
          ),
    );
  }
}
