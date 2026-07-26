import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/theme.dart';

/// OpenStreetMap tile view with a single branded pin.
///
/// The marker is a filled teardrop on `primary` with a light ring, so it stays
/// readable against arbitrary map tiles rather than blending into them.
class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget({
    required this.latLng,
    super.key,
    this.mapController,
    this.zoom = 17,
  });

  final LatLng latLng;
  final MapController? mapController;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latLng,
        initialZoom: zoom,
        backgroundColor: colors.surfaceContainer,
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sweet.shop',
        ),
        MarkerLayer(
          markers: <Marker>[
            Marker(
              point: latLng,
              width: 44,
              height: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.onPrimary, width: 3),
                ),
                child: Icon(
                  Symbols.storefront_rounded,
                  color: colors.onPrimary,
                  size: 22,
                  fill: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
