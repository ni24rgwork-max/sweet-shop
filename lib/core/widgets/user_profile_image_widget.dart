import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../theme/dimens.dart';

/// Circular avatar for the signed-in user.
///
/// Collapses to a single [diameter] so the clip can never disagree with the
/// box — passing mismatched width/height used to yield an oval clipped to a
/// circle.
class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({super.key, double? width, double? height})
    : diameter = width ?? height ?? _defaultDiameter;

  static const double _defaultDiameter = 50;

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.largePadding),
      child: ClipOval(
        child: Image.asset(
          Assets.images.profileImage.path,
          width: diameter,
          height: diameter,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
