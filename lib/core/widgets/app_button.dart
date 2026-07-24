import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'app_svg_viewer.dart';

/// Primary call-to-action.
///
/// Shape, height, padding and text style all come from `filledButtonTheme`, so
/// this is a thin convenience wrapper rather than a restatement of the design.
/// Pass [tonal] for a secondary-emphasis action.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    super.key,
    this.iconPath,
    this.margin,
    this.tonal = false,
    this.expand = true,
  });

  final String title;
  final VoidCallback? onPressed;
  final String? iconPath;
  final EdgeInsets? margin;

  /// Secondary emphasis — filled with `secondaryContainer` instead of `primary`.
  final bool tonal;

  /// Whether the button stretches to the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final Color foreground = tonal
        ? colors.onSecondaryContainer
        : colors.onPrimary;

    final Widget label = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (iconPath != null) ...<Widget>[
          AppSvgViewer(iconPath!, width: 20, color: foreground),
          const SizedBox(width: Dimens.mediumPadding),
        ],
        Text(title),
      ],
    );

    final Widget button = tonal
        ? FilledButton.tonal(onPressed: onPressed, child: label)
        : FilledButton(onPressed: onPressed, child: label);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
