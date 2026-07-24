import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Circular avatar with an optional ring.
class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    required this.imagePath,
    super.key,
    this.width,
    this.height,
    this.hasBorder = true,
  });

  final String imagePath;
  final double? width;
  final double? height;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      width: width ?? 120,
      height: height ?? 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(width: 2, color: colors.primaryContainer)
            : null,
      ),
      child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
    );
  }
}
