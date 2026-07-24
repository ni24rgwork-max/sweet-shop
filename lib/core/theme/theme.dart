// CupertinoPageTransitionsBuilder lives in cupertino/route.dart, not material.
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_semantics.dart';
import 'app_shapes.dart';
import 'app_typography.dart';
import 'dimens.dart';

export 'app_color_scheme.dart';
export 'app_motion.dart';
export 'app_semantics.dart';
export 'app_shapes.dart';
export 'app_typography.dart';

/// Assembles the two [ThemeData]s.
///
/// Component themes carry the shape and colour decisions so that individual
/// screens can use plain Material widgets — `FilledButton`, `FilterChip`,
/// `Card` — and inherit the design automatically, instead of each call site
/// restating radii and colours.
abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(AppColorScheme.light, AppSemantics.light);
  static ThemeData get dark => _build(AppColorScheme.dark, AppSemantics.dark);

  static ThemeData _build(ColorScheme scheme, AppSemantics semantics) {
    final TextTheme text = AppTypography.textTheme(
      scheme.onSurface,
      scheme.onSurfaceVariant,
    );

    return ThemeData(
      colorScheme: scheme,
      textTheme: text,
      extensions: <ThemeExtension<dynamic>>[semantics],
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.headlineSmall,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.secondaryContainer,
        indicatorShape: AppShapes.pill,
        elevation: 0,
        height: 76,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return text.labelMedium!.copyWith(
            color: selected ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 24,
            color: selected ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
          );
        }),
      ),

      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: AppShapes.card,
        clipBehavior: Clip.antiAlias,
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: AppShapes.pill,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.largePadding),
          textStyle: text.labelLarge,
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: AppShapes.pill,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.largePadding),
          textStyle: text.labelLarge,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: AppShapes.pill,
          textStyle: text.labelLarge,
          foregroundColor: scheme.primary,
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: AppShapes.pill,
          minimumSize: const Size.square(48),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainer,
        selectedColor: scheme.secondaryContainer,
        checkmarkColor: scheme.onSecondaryContainer,
        side: BorderSide.none,
        shape: AppShapes.chip,
        labelStyle: text.labelLarge,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.mediumPadding,
          vertical: Dimens.padding,
        ),
        showCheckmark: false,
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStatePropertyAll(scheme.surfaceContainer),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(0),
        shape: const WidgetStatePropertyAll(AppShapes.pill),
        hintStyle: WidgetStatePropertyAll(
          text.bodyLarge!.copyWith(color: scheme.onSurfaceVariant),
        ),
        textStyle: WidgetStatePropertyAll(text.bodyLarge),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: Dimens.largePadding),
        ),
      ),

      searchViewTheme: SearchViewThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        dividerColor: scheme.outlineVariant,
        headerHintStyle: text.bodyLarge!.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        headerTextStyle: text.bodyLarge,
        shape: const RoundedRectangleBorder(borderRadius: AppShapes.radiusXl),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleColor: scheme.outlineVariant,
        shape: const RoundedRectangleBorder(borderRadius: AppShapes.sheetTop),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppShapes.radiusXxl),
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyMedium,
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          shape: AppShapes.pill,
          selectedBackgroundColor: scheme.secondaryContainer,
          selectedForegroundColor: scheme.onSecondaryContainer,
          textStyle: text.labelLarge,
        ),
      ),

      // Individual properties rather than the `year2023: false` shorthand,
      // which is deprecated as of v3.27 and would reintroduce an analyzer
      // warning.
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.surfaceContainerHighest,
        thumbColor: scheme.primary,
        overlayColor: scheme.primary.withValues(alpha: 0.12),
        trackHeight: 12,
        trackGap: 6,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.onPrimary
              : scheme.outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surfaceContainerHighest,
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.outline,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: Dimens.largePadding,
      ),

      listTileTheme: ListTileThemeData(
        shape: const RoundedRectangleBorder(borderRadius: AppShapes.radiusMd),
        titleTextStyle: text.titleMedium,
        subtitleTextStyle: text.bodySmall!.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        iconColor: scheme.onSurfaceVariant,
      ),

      tabBarTheme: TabBarThemeData(
        labelStyle: text.titleSmall,
        unselectedLabelStyle: text.titleSmall,
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: scheme.primary, width: 3),
          borderRadius: AppShapes.radiusXs,
          insets: const EdgeInsets.symmetric(horizontal: Dimens.padding),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: text.bodyMedium!.copyWith(
          color: scheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppShapes.radiusMd),
        elevation: 0,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

/// `Theme.of(context)` shorthand.
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;

  /// Roles Material 3 has no slot for — see [AppSemantics].
  AppSemantics get semantics => Theme.of(this).extension<AppSemantics>()!;
}
