import 'package:flutter/material.dart';

/// Shape scale.
///
/// Material 3 Expressive leans on noticeably larger radii than baseline M3 —
/// generous rounding on containers, fully-stadium call-to-actions — which is a
/// large part of why the language reads as it does.
abstract final class AppShapes {
  const AppShapes._();

  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 28;
  static const double xxl = 32;
  static const double hero = 40;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusHero = BorderRadius.all(
    Radius.circular(hero),
  );

  /// Bottom sheets and pinned panels — rounded top corners only.
  static const BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(xxl),
  );

  static const RoundedRectangleBorder card = RoundedRectangleBorder(
    borderRadius: radiusXl,
  );

  static const RoundedRectangleBorder chip = RoundedRectangleBorder(
    borderRadius: radiusSm,
  );

  static const StadiumBorder pill = StadiumBorder();
}
