import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Selectable chip for weights, filters and category pills.
///
/// Colours and shape come from `chipTheme`; only the selected label colour needs
/// resolving here, since it flips between two `on*` roles.
class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    required this.label,
    required this.selected,
    super.key,
    this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      labelStyle: context.text.labelLarge?.copyWith(
        color: selected ? colors.onSecondaryContainer : colors.onSurfaceVariant,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
      ),
    );
  }
}
