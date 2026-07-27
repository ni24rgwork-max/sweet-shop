// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apple-logo.svg
  String get appleLogo => 'assets/icons/apple-logo.svg';

  /// File path: assets/icons/google-logo.svg
  String get googleLogo => 'assets/icons/google-logo.svg';

  /// File path: assets/icons/paypal-logo.svg
  String get paypalLogo => 'assets/icons/paypal-logo.svg';

  /// List of all assets
  List<String> get values => [appleLogo, googleLogo, paypalLogo];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Special offer 1.png
  AssetGenImage get specialOffer1 =>
      const AssetGenImage('assets/images/Special offer 1.png');

  /// File path: assets/images/Special offer 2.png
  AssetGenImage get specialOffer2 =>
      const AssetGenImage('assets/images/Special offer 2.png');

  /// File path: assets/images/Special offer 3.png
  AssetGenImage get specialOffer3 =>
      const AssetGenImage('assets/images/Special offer 3.png');

  /// File path: assets/images/Special offer 4.png
  AssetGenImage get specialOffer4 =>
      const AssetGenImage('assets/images/Special offer 4.png');

  /// File path: assets/images/birthday cake category 1.png
  AssetGenImage get birthdayCakeCategory1 =>
      const AssetGenImage('assets/images/birthday cake category 1.png');

  /// File path: assets/images/birthday cake category 2.png
  AssetGenImage get birthdayCakeCategory2 =>
      const AssetGenImage('assets/images/birthday cake category 2.png');

  /// File path: assets/images/birthday cake category 3.png
  AssetGenImage get birthdayCakeCategory3 =>
      const AssetGenImage('assets/images/birthday cake category 3.png');

  /// File path: assets/images/cake illustration.png
  AssetGenImage get cakeIllustration =>
      const AssetGenImage('assets/images/cake illustration.png');

  /// File path: assets/images/cupcake category 1.png
  AssetGenImage get cupcakeCategory1 =>
      const AssetGenImage('assets/images/cupcake category 1.png');

  /// File path: assets/images/cupcake category 2.png
  AssetGenImage get cupcakeCategory2 =>
      const AssetGenImage('assets/images/cupcake category 2.png');

  /// File path: assets/images/cupcake category 3.png
  AssetGenImage get cupcakeCategory3 =>
      const AssetGenImage('assets/images/cupcake category 3.png');

  /// File path: assets/images/cupcake illustration.png
  AssetGenImage get cupcakeIllustration =>
      const AssetGenImage('assets/images/cupcake illustration.png');

  /// File path: assets/images/donut category 1.png
  AssetGenImage get donutCategory1 =>
      const AssetGenImage('assets/images/donut category 1.png');

  /// File path: assets/images/donut category 2.png
  AssetGenImage get donutCategory2 =>
      const AssetGenImage('assets/images/donut category 2.png');

  /// File path: assets/images/donut category 3.png
  AssetGenImage get donutCategory3 =>
      const AssetGenImage('assets/images/donut category 3.png');

  /// File path: assets/images/donut illustration.png
  AssetGenImage get donutIllustration =>
      const AssetGenImage('assets/images/donut illustration.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/map-img-1.png
  AssetGenImage get mapImg1 =>
      const AssetGenImage('assets/images/map-img-1.png');

  /// File path: assets/images/map-img-2.png
  AssetGenImage get mapImg2 =>
      const AssetGenImage('assets/images/map-img-2.png');

  /// File path: assets/images/pastry illustration.png
  AssetGenImage get pastryIllustration =>
      const AssetGenImage('assets/images/pastry illustration.png');

  /// File path: assets/images/profile-image.png
  AssetGenImage get profileImage =>
      const AssetGenImage('assets/images/profile-image.png');

  /// File path: assets/images/red velvet cake with fruit.png
  AssetGenImage get redVelvetCakeWithFruit =>
      const AssetGenImage('assets/images/red velvet cake with fruit.png');

  /// File path: assets/images/strawberry chocolate cake.png
  AssetGenImage get strawberryChocolateCake =>
      const AssetGenImage('assets/images/strawberry chocolate cake.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    specialOffer1,
    specialOffer2,
    specialOffer3,
    specialOffer4,
    birthdayCakeCategory1,
    birthdayCakeCategory2,
    birthdayCakeCategory3,
    cakeIllustration,
    cupcakeCategory1,
    cupcakeCategory2,
    cupcakeCategory3,
    cupcakeIllustration,
    donutCategory1,
    donutCategory2,
    donutCategory3,
    donutIllustration,
    logo,
    mapImg1,
    mapImg2,
    pastryIllustration,
    profileImage,
    redVelvetCakeWithFruit,
    strawberryChocolateCake,
  ];
}

abstract final class Assets {
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
