import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Top of the home tab.
///
/// A collapsing sliver rather than a fixed [AppBar]: the greeting is set in
/// Fraunces at display size and scrolls away, which is what gives the screen its
/// editorial opening. The previous version painted a saturated primary block
/// across the whole top of the screen — the tonal surface here lets the food
/// photography below be the only saturated thing on screen.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  static String _greeting() {
    final int hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SliverAppBar(
      pinned: false,
      floating: false,
      expandedHeight: 156,
      collapsedHeight: 72,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: Dimens.gutter,
      title: Row(
        children: <Widget>[
          Icon(
            Symbols.location_on,
            size: 16,
            color: colors.primary,
          ),
          const SizedBox(width: Dimens.smallPadding),
          Text(
            'New York',
            style: context.text.labelLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          _NotificationButton(),
          const SizedBox(width: Dimens.padding),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          0,
          Dimens.gutter,
          Dimens.mediumPadding,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _greeting(),
              style: context.text.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Dimens.smallPadding / 2),
            Text(
              'Something sweet?',
              style: context.text.displaySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: colors.surfaceContainer,
            shape: AppShapes.pill,
          ),
          icon: Icon(
            Symbols.notifications,
            size: 20,
            color: colors.onSurface,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
