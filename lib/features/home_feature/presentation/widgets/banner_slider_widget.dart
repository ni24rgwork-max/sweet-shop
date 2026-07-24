import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../data/data_source/local/sample_data.dart';

/// Special-offer carousel.
///
/// Built on the SDK's [CarouselView.weighted] in the Material "hero" layout: one
/// dominant item with the next one peeking in at the right edge, so the row
/// visibly invites a swipe. This replaced `carousel_slider` plus
/// `smooth_page_indicator` plus a dedicated cubit — the weights, snapping and
/// index reporting are all built in now.
class BannerSliderWidget extends StatefulWidget {
  const BannerSliderWidget({super.key});

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Column(
      children: <Widget>[
        SizedBox(
          height: 172,
          child: CarouselView.weighted(
            flexWeights: const <int>[7, 1],
            itemSnapping: true,
            infinite: true,
            shrinkExtent: 200,
            backgroundColor: colors.surfaceContainer,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.smallPadding,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppShapes.radiusXl,
            ),
            overlayColor: WidgetStatePropertyAll<Color>(
              colors.onSurface.withValues(alpha: 0.08),
            ),
            onIndexChanged: (int index) => setState(() => _index = index),
            onTap: (_) {},
            children: <Widget>[
              for (final String banner in banners)
                Image.asset(banner, fit: BoxFit.cover),
            ],
          ),
        ),
        const SizedBox(height: Dimens.mediumPadding),
        _Dots(count: banners.length, active: _index),
      ],
    );
  }
}

/// Page indicator. A selected dot stretches into a short bar rather than just
/// changing colour, which reads at a glance.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppMotion.spatialCurve,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 6,
            width: i == active ? 20 : 6,
            decoration: BoxDecoration(
              color: i == active
                  ? colors.primary
                  : colors.onSurfaceVariant.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
