import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';

/// Opening screen.
///
/// The logo settles in on a real spring rather than a fixed curve, so the
/// overshoot is physical — this is the app's first frame and the clearest place
/// to establish the motion language.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController.unbounded(
    vsync: this,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller.animateWith(
      SpringSimulation(AppMotion.spatialSlow, 0, 1, 0),
    );

    _timer = Timer(const Duration(milliseconds: 1900), () {
      if (mounted) context.go(Routes.home);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfaceContainer,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            final double t = _controller.value.clamp(0.0, 1.4);
            return Opacity(
              opacity: t.clamp(0.0, 1.0),
              child: Transform.scale(scale: 0.82 + (t * 0.18), child: child),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Assets.images.logo.image(width: 260),
              const SizedBox(height: Dimens.veryLargePadding),
              Text(
                'Baked fresh, every morning',
                style: context.text.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
