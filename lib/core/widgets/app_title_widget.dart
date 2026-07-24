import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../theme/dimens.dart';
import '../theme/theme.dart';
import 'app_text_button.dart';

/// Section header — a Fraunces headline plus an optional "See all".
///
/// The serif at headline size is what separates sections visually, so the
/// previous bold-body treatment is replaced by the display family.
class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({
    required this.title,
    super.key,
    this.thumbnailPath,
    this.onPressed,
  });

  final String title;
  final String? thumbnailPath;
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
                if (thumbnailPath != null)
                  Image.asset(thumbnailPath!, width: 30, height: 30),
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
              iconPath: Assets.icons.arrowRight1,
            ),
        ],
      ),
    );
  }
}
