import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../gen/assets.gen.dart';
import '../theme/dimens.dart';
import 'app_bordered_icon_button.dart';

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
      leading: showBackIcon
          ? Padding(
              padding: const EdgeInsets.only(left: Dimens.gutter),
              child: AppBorderedIconButton(
                iconPath: Assets.icons.arrowLeft,
                onPressed: () => context.pop(),
              ),
            )
          : null,
      leadingWidth: showBackIcon ? 72 : null,
      titleSpacing: showBackIcon ? 0 : Dimens.gutter,
      bottom: bottom,
      toolbarHeight: 72,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((height ?? 72) + (bottom?.preferredSize.height ?? 0));
}
