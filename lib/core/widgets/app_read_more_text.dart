import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../theme/theme.dart';

/// Collapsible body copy, used for product descriptions.
class AppReadMoreText extends StatelessWidget {
  const AppReadMoreText(
    this.text, {
    super.key,
    this.textAlign,
    this.style,
    this.trimLines,
  });

  final String? text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? trimLines;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final TextStyle link =
        context.text.labelLarge?.copyWith(color: colors.primary) ??
        TextStyle(color: colors.primary);

    return ReadMoreText(
      text ?? '',
      textAlign: textAlign ?? TextAlign.start,
      trimLines: trimLines ?? 4,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Read more',
      trimExpandedText: '  Read less',
      style:
          style ??
          context.text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
      moreStyle: link,
      lessStyle: link,
    );
  }
}
