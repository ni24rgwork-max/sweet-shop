import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';
import '../../../core/theme/dimens.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_svg_viewer.dart';

/// Nearby store cards that float over the map.
///
/// Cards sit on `surfaceContainerLow` with a hairline outline so they stay
/// readable over arbitrary map tiles — the previous version used the scaffold
/// background, which disappeared against pale tiles.
class StoresOnMapScreen extends StatelessWidget {
  const StoresOnMapScreen({super.key});

  static const List<_Store> _stores = <_Store>[
    _Store('Sweets Craze', '93 Worth St, New York', '15 min · 1.8 km'),
    _Store('Urban Delights', '211 Canal St, New York', '18 min · 2.3 km'),
    _Store('The Gilded Tart', '5 Mercer St, New York', '22 min · 3.1 km'),
    _Store('Velvet Crumb', '88 Grand St, New York', '25 min · 3.6 km'),
    _Store("Marie's Tea Room", '14 Prince St, New York', '28 min · 4.0 km'),
    _Store('The Dancing Scone', '40 Bond St, New York', '31 min · 4.4 km'),
    _Store('The Jolly Croissant', '7 Bleecker St, New York', '35 min · 5.2 km'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.gutter),
        itemCount: _stores.length,
        separatorBuilder: (_, _) => const SizedBox(width: Dimens.mediumPadding),
        itemBuilder: (BuildContext context, int index) =>
            _StoreCard(store: _stores[index], useAltImage: index.isOdd),
      ),
    );
  }
}

class _Store {
  const _Store(this.name, this.address, this.distance);

  final String name;
  final String address;
  final String distance;
}

class _StoreCard extends StatelessWidget {
  const _StoreCard({required this.store, required this.useAltImage});

  final _Store store;
  final bool useAltImage;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppShapes.radiusXl,
        border: Border.all(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (useAltImage ? Assets.images.mapImg2 : Assets.images.mapImg1).image(
            width: 260,
            height: 84,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  store.name,
                  style: context.text.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Cakes · cupcakes · donuts',
                  style: context.text.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.padding),
                _MetaRow(iconPath: Assets.icons.location, text: store.address),
                const SizedBox(height: Dimens.smallPadding),
                _MetaRow(
                  iconPath: Assets.icons.clock,
                  text: '${store.distance} · free delivery',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.iconPath, required this.text});

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Row(
      children: <Widget>[
        AppSvgViewer(iconPath, width: 13, color: colors.primary),
        const SizedBox(width: Dimens.smallPadding),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
