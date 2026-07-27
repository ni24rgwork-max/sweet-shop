import 'package:flutter/material.dart';

import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'app_text_button.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Section header — a Fraunces headline plus an optional "See all".
///
/// The serif at headline size is what separates sections visually, so the
/// previous bold-body treatment is replaced by the display family.
class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({
    required this.title,
    super.key,
    this.thumbnail,
    this.onPressed,
  });

  final String title;
  final IconData? thumbnail;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.gutter,
        right: Dimens.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              spacing: Dimens.mediumPadding,
              children: <Widget>[
                if (thumbnail != null)
                  Icon(thumbnail, size: 26, color: context.colors.primary),
                Expanded(
                  child: Text(
                    title,
                    style: context.text.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (onPressed != null)
            AppTextButton(
              onPressed: onPressed,
              title: 'See all',
              icon: Symbols.arrow_forward,
            ),
        ],
      ),
    );
  }
}
