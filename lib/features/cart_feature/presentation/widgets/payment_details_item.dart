import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';

/// One label/amount line in the payment breakdown.
class PaymentDetailsItem extends StatelessWidget {
  const PaymentDetailsItem({
    required this.title,
    required this.subtitle,
    super.key,
    this.emphasised = false,
  });

  final String title;
  final String subtitle;

  /// Used for the total line — heavier weight, full-contrast colour.
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.padding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: emphasised
                  ? context.text.titleMedium
                  : context.text.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
            ),
          ),
          Text(
            subtitle,
            style: AppTypography.price(
              emphasised ? 18 : 14,
              weight: emphasised ? FontWeight.w800 : FontWeight.w600,
            ).copyWith(color: colors.onSurface),
          ),
        ],
      ),
    );
  }
}
