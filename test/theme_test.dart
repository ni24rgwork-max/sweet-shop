import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_shop/core/theme/theme.dart';

/// Damping ratio of a spring. 1.0 is critically damped — the boundary above
/// which a spring stops overshooting.
double _dampingRatio(SpringDescription spring) =>
    spring.damping / (2 * math.sqrt(spring.mass * spring.stiffness));

void main() {
  setUpAll(() {
    // Never reach for the network in tests.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppColorScheme', () {
    test('both schemes derive from the one berry seed', () {
      expect(AppColorScheme.seed, const Color(0xFFA8536B));
      expect(AppColorScheme.light.brightness, Brightness.light);
      expect(AppColorScheme.dark.brightness, Brightness.dark);
    });

    test('generated neutrals are overridden towards cream and berry-dark', () {
      expect(AppColorScheme.light.surface, const Color(0xFFFFF8F5));
      expect(AppColorScheme.dark.surface, const Color(0xFF1A1113));
    });

    test('surface containers ascend in the light scheme', () {
      final ColorScheme s = AppColorScheme.light;
      final List<double> steps = <Color>[
        s.surfaceContainerLowest,
        s.surfaceContainerLow,
        s.surfaceContainer,
        s.surfaceContainerHigh,
        s.surfaceContainerHighest,
      ].map((Color c) => c.computeLuminance()).toList();

      for (int i = 1; i < steps.length; i++) {
        expect(
          steps[i],
          lessThan(steps[i - 1]),
          reason: 'light containers must darken as they rise',
        );
      }
    });

    test('body text clears WCAG AA against its own surface', () {
      for (final ColorScheme scheme in <ColorScheme>[
        AppColorScheme.light,
        AppColorScheme.dark,
      ]) {
        final double a = scheme.onSurface.computeLuminance();
        final double b = scheme.surface.computeLuminance();
        final double ratio =
            (math.max(a, b) + 0.05) / (math.min(a, b) + 0.05);
        expect(ratio, greaterThanOrEqualTo(4.5));
      }
    });
  });

  group('AppShapes', () {
    test('the radius scale ascends', () {
      final List<double> scale = <double>[
        AppShapes.xs,
        AppShapes.sm,
        AppShapes.md,
        AppShapes.lg,
        AppShapes.xl,
        AppShapes.xxl,
        AppShapes.hero,
      ];
      for (int i = 1; i < scale.length; i++) {
        expect(scale[i], greaterThan(scale[i - 1]));
      }
    });

    test('sheets round only their top corners', () {
      expect(AppShapes.sheetTop.bottomLeft, Radius.zero);
      expect(AppShapes.sheetTop.bottomRight, Radius.zero);
      expect(AppShapes.sheetTop.topLeft.x, AppShapes.xxl);
    });
  });

  group('AppMotion', () {
    test('durations ascend', () {
      expect(AppMotion.instant, lessThan(AppMotion.fast));
      expect(AppMotion.fast, lessThan(AppMotion.normal));
      expect(AppMotion.normal, lessThan(AppMotion.slow));
      expect(AppMotion.slow, lessThan(AppMotion.deliberate));
    });

    test('effects are critically damped — colour must never overshoot', () {
      expect(_dampingRatio(AppMotion.effects), closeTo(1, 0.01));
    });

    test('spatial springs are underdamped, and bounce more as they slow', () {
      final double fast = _dampingRatio(AppMotion.spatialFast);
      final double normal = _dampingRatio(AppMotion.spatial);
      final double slow = _dampingRatio(AppMotion.spatialSlow);

      expect(fast, lessThan(1));
      expect(normal, lessThan(fast));
      expect(slow, lessThan(normal));
    });
  });

  group('AppSemantics', () {
    test('lerp interpolates every role between the two brightnesses', () {
      final AppSemantics mid =
          AppSemantics.light.lerp(AppSemantics.dark, 0.5);

      expect(mid.success, Color.lerp(AppSemantics.light.success, AppSemantics.dark.success, 0.5));
      expect(mid.rating, Color.lerp(AppSemantics.light.rating, AppSemantics.dark.rating, 0.5));
    });

    test('lerp against a foreign extension returns this, not null', () {
      expect(AppSemantics.light.lerp(null, 0.5), same(AppSemantics.light));
    });

    test('copyWith replaces only what it is given', () {
      final AppSemantics tweaked =
          AppSemantics.light.copyWith(rating: const Color(0xFF00FF00));

      expect(tweaked.rating, const Color(0xFF00FF00));
      expect(tweaked.success, AppSemantics.light.success);
      expect(tweaked.priceAccent, AppSemantics.light.priceAccent);
    });
  });

  group('AppTheme', () {
    testWidgets('each brightness carries its own semantics extension',
        (WidgetTester tester) async {
      expect(
        AppTheme.light.extension<AppSemantics>(),
        AppSemantics.light,
      );
      expect(
        AppTheme.dark.extension<AppSemantics>(),
        AppSemantics.dark,
      );
    });

    testWidgets('scaffold background tracks the scheme surface',
        (WidgetTester tester) async {
      expect(AppTheme.light.scaffoldBackgroundColor, AppColorScheme.light.surface);
      expect(AppTheme.dark.scaffoldBackgroundColor, AppColorScheme.dark.surface);
    });

    testWidgets('widgets resolve the theme through the standard accessors',
        (WidgetTester tester) async {
      late ThemeData resolved;
      late AppSemantics semantics;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Builder(
            builder: (BuildContext context) {
              resolved = Theme.of(context);
              semantics = Theme.of(context).extension<AppSemantics>()!;
              return const Scaffold(body: Text('Sweet Shop'));
            },
          ),
        ),
      );

      expect(find.text('Sweet Shop'), findsOneWidget);
      expect(resolved.colorScheme.surface, AppColorScheme.light.surface);
      expect(resolved.textTheme.bodyMedium, isNotNull);
      expect(semantics.priceAccent, AppSemantics.light.priceAccent);
    });
  });
}
