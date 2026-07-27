import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Settings-style row, used down the profile tab.
///
/// The leading icon sits in a tonal rounded square so the list reads as a set of
/// items rather than a column of loose glyphs.
class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.onTap,
    required this.title,
    required this.leadingIcon,
    super.key,
    this.trailing,
    this.padding,
    this.destructive = false,
  });

  final VoidCallback onTap;
  final String title;
  final IconData leadingIcon;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  /// Renders in the error role — sign out, delete account.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final Color foreground = destructive ? colors.error : colors.onSurface;

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: Dimens.gutter),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.padding,
          vertical: Dimens.smallPadding,
        ),
        title: Text(
          title,
          style: context.text.titleMedium?.copyWith(color: foreground),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: destructive
                ? colors.errorContainer
                : colors.surfaceContainerHigh,
            borderRadius: AppShapes.radiusSm,
          ),
          child: Center(
            child: Icon(
              leadingIcon,
              size: 19,
              color: destructive ? colors.onErrorContainer : foreground,
            ),
          ),
        ),
        trailing:
            trailing ??
            Icon(
              Symbols.chevron_right,
              size: 15,
              color: colors.onSurfaceVariant,
            ),
      ),
    );
  }
}
