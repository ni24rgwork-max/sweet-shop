import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/dimens.dart';
import '../../../core/widgets/flutter_map_widget.dart';
import '../../../core/widgets/general_app_bar.dart';
import '../widgets/stores_on_map_screen.dart';

/// Store locator.
///
/// The map fills the screen and the store rail floats over it, clear of the
/// navigation bar. `extendBodyBehindAppBar` lets tiles run under the translucent
/// top bar rather than starting below it.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GeneralAppBar(title: 'Nearby stores', showBackIcon: false),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          const FlutterMapWidget(latLng: LatLng(40.7178, -74.0035), zoom: 15),
          const Padding(
            // Clears the floating navigation bar.
            padding: EdgeInsets.only(bottom: 100),
            child: StoresOnMapScreen(),
          ),
          Positioned(
            top: Dimens.mediumPadding,
            right: Dimens.gutter,
            child: SafeArea(child: _RecenterButton()),
          ),
        ],
      ),
    );
  }
}

class _RecenterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {},
      elevation: 0,
      child: const Icon(Icons.my_location),
    );
  }
}
