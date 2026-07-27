import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';

/// Chrome around the five bottom-nav destinations.
///
/// The bar floats clear of the screen edge rather than sitting flush against it,
/// which is what gives the expressive layout its air. The body extends behind
/// it so content scrolls under the bar instead of stopping at a hard line.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  static const List<_Destination> _destinations = <_Destination>[
    _Destination('Home', Symbols.home),
    _Destination('Cart', Symbols.shopping_cart),
    _Destination('Orders', Symbols.receipt_long),
    _Destination('Map', Symbols.map),
    _Destination('Profile', Symbols.person),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Scaffold(
      extendBody: true,
      body: shell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.mediumPadding,
          0,
          Dimens.mediumPadding,
          Dimens.mediumPadding,
        ),
        child: ClipRRect(
          borderRadius: AppShapes.radiusXxl,
          child: DecoratedBox(
            decoration: BoxDecoration(
              // surfaceContainer rather than …Low: the bar floats over scrolling
              // content, so it needs to separate from the surface behind it.
              color: colors.surfaceContainer,
              borderRadius: AppShapes.radiusXxl,
              border: Border.all(color: colors.outlineVariant),
            ),
            child: NavigationBar(
              selectedIndex: shell.currentIndex,
              backgroundColor: Colors.transparent,
              onDestinationSelected: (int index) => shell.goBranch(
                index,
                // Tapping the active tab returns it to its root, the
                // conventional behaviour for a tab bar.
                initialLocation: index == shell.currentIndex,
              ),
              destinations: <Widget>[
                for (final _Destination destination in _destinations)
                  NavigationDestination(
                    icon: Icon(
                      destination.icon,
                      color: colors.onSurfaceVariant,
                    ),
                    selectedIcon: Icon(
                      destination.icon,
                      color: colors.onSecondaryContainer,
                    ),
                    label: destination.label,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// Holds the five branch navigators and cross-fades between them.
///
/// Material's pattern for switching top-level destinations is fade-through, not
/// a hard cut. Every branch stays in the tree — offstage and non-hit-testable
/// when inactive — so scroll positions and navigation stacks survive a switch.
class BranchContainer extends StatelessWidget {
  const BranchContainer({
    required this.currentIndex,
    required this.children,
    super.key,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (int i = 0; i < children.length; i++)
          AnimatedOpacity(
            opacity: i == currentIndex ? 1 : 0,
            duration: AppMotion.fast,
            curve: AppMotion.effectsCurve,
            child: _KeepAlive(
              active: i == currentIndex,
              child: children[i],
            ),
          ),
      ],
    );
  }
}

class _KeepAlive extends StatelessWidget {
  const _KeepAlive({required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !active,
      child: TickerMode(
        enabled: active,
        child: Offstage(offstage: !active, child: child),
      ),
    );
  }
}
