import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../data/data_source/local/sample_data.dart';

/// Horizontal category picker.
///
/// Selection is tonal — the active tile fills with `secondaryContainer` and its
/// label goes semibold — rather than the previous coloured drop shadow, which
/// was the only shadow anywhere in the design.
class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.gutter),
        itemCount: titlesOfCategories.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: Dimens.mediumPadding),
        itemBuilder: (BuildContext context, int index) {
          final bool selected = index == _selected;

          return GestureDetector(
            onTap: () => setState(() => _selected = index),
            child: SizedBox(
              width: 78,
              child: Column(
                children: <Widget>[
                  AnimatedContainer(
                    duration: AppMotion.fast,
                    curve: AppMotion.effectsCurve,
                    width: 74,
                    height: 74,
                    padding: const EdgeInsets.all(Dimens.mediumPadding),
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.secondaryContainer
                          : colors.surfaceContainer,
                      borderRadius: AppShapes.radiusLg,
                      border: Border.all(
                        color: selected
                            ? colors.primary.withValues(alpha: 0.45)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Image.asset(imagesOfCategories[index]),
                  ),
                  const SizedBox(height: Dimens.padding),
                  Text(
                    titlesOfCategories[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.text.labelMedium?.copyWith(
                      color: selected
                          ? colors.onSurface
                          : colors.onSurfaceVariant,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
