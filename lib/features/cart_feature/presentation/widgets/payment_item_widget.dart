import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';

/// A selectable payment method.
///
/// The radio takes its group state from a [RadioGroup] ancestor. `Radio.groupValue`
/// and `Radio.onChanged` were deprecated after Flutter 3.32 and using them was
/// what produced two of the four analyzer warnings this rewrite clears.
class PaymentItemWidget extends StatelessWidget {
  const PaymentItemWidget({
    required this.title,
    super.key,
    this.value,
    this.onTap,
    this.icon,
    this.showBorder = true,
    this.showRadio = true,
    this.selected = false,
  });

  final String title;

  /// Identity within the enclosing [RadioGroup]. Required when [showRadio].
  final String? value;

  final VoidCallback? onTap;
  final IconData? icon;
  final bool showBorder;
  final bool showRadio;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Material(
      color: selected ? colors.secondaryContainer : colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppShapes.radiusMd,
        side: showBorder
            ? BorderSide(
                color: selected ? colors.primary : colors.outlineVariant,
                width: selected ? 1.5 : 1,
              )
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.mediumPadding,
            vertical: Dimens.smallPadding,
          ),
          child: Row(
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    borderRadius: AppShapes.radiusSm,
                  ),
                  child: Center(
                    child: Icon(icon, size: 20, color: colors.onSurface),
                  ),
                ),
                const SizedBox(width: Dimens.mediumPadding),
              ],
              Expanded(
                child: Text(
                  title,
                  style: context.text.titleSmall?.copyWith(
                    color: selected
                        ? colors.onSecondaryContainer
                        : colors.onSurface,
                  ),
                ),
              ),
              if (showRadio && value != null)
                Radio<String>(value: value!)
              else
                Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
