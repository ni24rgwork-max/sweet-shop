import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_svg_viewer.dart';

/// Chrome around the five bottom-nav destinations.
///
/// The bar floats clear of the screen edge rather than sitting flush against it,
/// which is what gives the expressive layout its air. The body extends behind
/// it so content scrolls under the bar instead of stopping at a hard line.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  static const List<_Destination> _destinations = <_Destination>[
    _Destination('Home', 'home2'),
    _Destination('Cart', 'shoppingCart'),
    _Destination('Orders', 'receipt'),
    _Destination('Map', 'map1'),
    _Destination('Profile', 'user'),
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
                    icon: _NavIcon(
                      destination.icon,
                      color: colors.onSurfaceVariant,
                    ),
                    selectedIcon: _NavIcon(
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
  final String icon;
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

class _NavIcon extends StatelessWidget {
  const _NavIcon(this.name, {required this.color});

  final String name;
  final Color color;

  /// The generated asset class exposes each icon as a named getter, so the name
  /// is mapped here rather than built as a path string — that keeps the
  /// compile-time check that the asset actually exists.
  static final Map<String, String> _paths = <String, String>{
    'home2': Assets.icons.home2,
    'shoppingCart': Assets.icons.shoppingCart,
    'receipt': Assets.icons.receipt,
    'map1': Assets.icons.map1,
    'user': Assets.icons.user,
  };

  @override
  Widget build(BuildContext context) {
    return AppSvgViewer(_paths[name]!, width: 24, height: 24, color: color);
  }
}
