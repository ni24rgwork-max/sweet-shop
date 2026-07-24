import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Renders one of the bundled SVG icons.
///
/// When no colour is given the icon takes `onSurfaceVariant` from the scheme, so
/// icons stay tonally consistent in both brightnesses. The previous version
/// hard-coded pure white in dark mode, which read louder than anything else on
/// the surface.
class AppSvgViewer extends StatelessWidget {
  const AppSvgViewer(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        color ?? context.colors.onSurfaceVariant,
        BlendMode.srcIn,
      ),
      fit: fit ?? BoxFit.contain,
    );
  }
}
