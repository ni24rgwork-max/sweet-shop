import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'app_svg_viewer.dart';

/// Star rating.
///
/// Set [pill] when it sits over photography, where it needs its own scrim to
/// stay legible against an unpredictable background.
class RateWidget extends StatelessWidget {
  const RateWidget({
    required this.rate,
    super.key,
    this.textColor,
    this.pill = false,
  });

  final String rate;
  final Color? textColor;
  final bool pill;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: Dimens.smallPadding,
      children: <Widget>[
        AppSvgViewer(
          Assets.icons.starFilled,
          color: context.semantics.rating,
          width: 14,
        ),
        Text(
          rate,
          style: AppTypography.price(12).copyWith(
            color: textColor ?? (pill ? colors.onSurface : colors.onSurfaceVariant),
          ),
        ),
      ],
    );

    if (!pill) return content;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.padding,
        vertical: Dimens.smallPadding * 0.75,
      ),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.88),
        borderRadius: AppShapes.radiusSm,
      ),
      child: content,
    );
  }
}
