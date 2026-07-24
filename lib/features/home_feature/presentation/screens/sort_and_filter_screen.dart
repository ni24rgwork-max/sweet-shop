import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../data/data_source/local/sample_data.dart';

/// How the products grid is ordered.
enum ProductSort {
  topRated('Top rated'),
  nearest('Nearest'),
  newest('Newest'),
  cheapest('Cheapest');

  const ProductSort(this.label);

  final String label;
}

/// The result of the sort-and-filter sheet.
class ProductFilters {
  const ProductFilters({
    this.sort = ProductSort.topRated,
    this.category = 'All',
    this.priceRange = const RangeValues(0, 100),
  });

  final ProductSort sort;
  final String category;
  final RangeValues priceRange;

  ProductFilters copyWith({
    ProductSort? sort,
    String? category,
    RangeValues? priceRange,
  }) {
    return ProductFilters(
      sort: sort ?? this.sort,
      category: category ?? this.category,
      priceRange: priceRange ?? this.priceRange,
    );
  }
}

/// Opens the sheet and resolves to the chosen filters, or null if dismissed.
///
/// This was a full pushed screen before. Sort and filter is a modal decision
/// that you return from — a bottom sheet keeps the grid visible behind it, and it
/// is the pattern Material specifies for this.
Future<ProductFilters?> showSortAndFilterSheet(
  BuildContext context, {
  required ProductFilters current,
}) {
  return showModalBottomSheet<ProductFilters>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) =>
        _SortAndFilterSheet(initial: current),
  );
}

class _SortAndFilterSheet extends StatefulWidget {
  const _SortAndFilterSheet({required this.initial});

  final ProductFilters initial;

  @override
  State<_SortAndFilterSheet> createState() => _SortAndFilterSheetState();
}

class _SortAndFilterSheetState extends State<_SortAndFilterSheet> {
  late ProductFilters _filters = widget.initial;

  /// Deduplicated — the sample category list repeats each name twice.
  List<String> get _categories =>
      <String>['All', ...<String>{...titlesOfCategories}];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.padding,
          Dimens.gutter,
          Dimens.gutter,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Sort & filter',
                    style: context.text.headlineSmall,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      setState(() => _filters = const ProductFilters()),
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: Dimens.largePadding),

            Text('Sort by', style: context.text.titleSmall),
            const SizedBox(height: Dimens.mediumPadding),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<ProductSort>(
                segments: <ButtonSegment<ProductSort>>[
                  for (final ProductSort sort in ProductSort.values)
                    ButtonSegment<ProductSort>(
                      value: sort,
                      label: Text(
                        sort.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                selected: <ProductSort>{_filters.sort},
                showSelectedIcon: false,
                onSelectionChanged: (Set<ProductSort> selection) => setState(
                  () => _filters = _filters.copyWith(sort: selection.first),
                ),
              ),
            ),

            const SizedBox(height: Dimens.largePadding),
            Text('Category', style: context.text.titleSmall),
            const SizedBox(height: Dimens.mediumPadding),
            Wrap(
              spacing: Dimens.padding,
              runSpacing: Dimens.padding,
              children: <Widget>[
                for (final String category in _categories)
                  FilterChip(
                    label: Text(category),
                    selected: _filters.category == category,
                    onSelected: (_) => setState(
                      () => _filters = _filters.copyWith(category: category),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: Dimens.largePadding),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Price', style: context.text.titleSmall),
                ),
                Text(
                  '\$${_filters.priceRange.start.round()} '
                  '– \$${_filters.priceRange.end.round()}',
                  style: AppTypography.price(14).copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: _filters.priceRange,
              max: 100,
              divisions: 20,
              onChanged: (RangeValues values) => setState(
                () => _filters = _filters.copyWith(priceRange: values),
              ),
            ),

            const SizedBox(height: Dimens.mediumPadding),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(_filters),
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
