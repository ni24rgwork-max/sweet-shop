import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/dimens.dart';
import 'app_bordered_icon_button.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Standard top bar for pushed screens.
///
/// The title uses the Fraunces headline from `appBarTheme`, and the back affordance
/// is a bordered circular button — carrying the pill language up into the chrome.
class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    required this.title,
    super.key,
    this.actions,
    this.showBackIcon = true,
    this.bottom,
    this.height,
  });

  final String title;
  final List<Widget>? actions;
  final bool showBackIcon;
  final PreferredSizeWidget? bottom;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        ...?actions,
        const SizedBox(width: Dimens.padding),
      ],
      // Center, not Padding alone: AppBar stretches `leading` to the full
      // toolbar height, and a stretched StadiumBorder renders as a vertical
      // ellipse rather than a circle.
      leading: showBackIcon
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: Dimens.gutter),
                child: AppBorderedIconButton(
                  icon: Symbols.arrow_back,
                  onPressed: () => context.pop(),
                ),
              ),
            )
          : null,
      leadingWidth: showBackIcon ? 76 : null,
      titleSpacing: showBackIcon ? Dimens.smallPadding : Dimens.gutter,
      bottom: bottom,
      toolbarHeight: 72,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((height ?? 72) + (bottom?.preferredSize.height ?? 0));
}
