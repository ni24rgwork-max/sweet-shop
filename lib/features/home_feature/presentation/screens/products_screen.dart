import 'package:flutter/material.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_svg_viewer.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../cart_feature/data/data_source/local/fake_products.dart';
import '../../../cart_feature/data/models/product_model.dart';
import '../widgets/product_card.dart';
import 'sort_and_filter_screen.dart';

/// Full product grid.
///
/// Sorting and filtering actually take effect here rather than being decorative:
/// the chips reflect the current [ProductFilters] and the grid re-sorts, so the
/// controls demonstrate real behaviour.
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductFilters _filters = const ProductFilters();

  List<ProductModel> get _products {
    final List<ProductModel> list = FakeProducts.products
        .where(
          (ProductModel p) =>
              p.price >= _filters.priceRange.start &&
              p.price <= _filters.priceRange.end,
        )
        .toList();

    switch (_filters.sort) {
      case ProductSort.topRated:
        list.sort((ProductModel a, ProductModel b) => b.rate.compareTo(a.rate));
      case ProductSort.cheapest:
        list.sort(
          (ProductModel a, ProductModel b) => a.price.compareTo(b.price),
        );
      case ProductSort.newest:
        list.sort((ProductModel a, ProductModel b) => b.id.compareTo(a.id));
      case ProductSort.nearest:
        // No location data in the sample set; leave in source order.
        break;
    }
    return list;
  }

  Future<void> _openSheet() async {
    final ProductFilters? result = await showSortAndFilterSheet(
      context,
      current: _filters,
    );
    if (result != null) setState(() => _filters = result);
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = _products;

    return Scaffold(
      appBar: GeneralAppBar(
        title: 'Products',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.gutter,
              0,
              Dimens.gutter,
              Dimens.mediumPadding,
            ),
            child: const AppSearchBar(),
          ),
        ),
        height: 72,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.gutter,
                Dimens.padding,
                Dimens.gutter,
                Dimens.mediumPadding,
              ),
              child: Row(
                children: <Widget>[
                  _ControlChip(
                    label: _filters.sort.label,
                    iconPath: Assets.icons.sort,
                    onTap: _openSheet,
                  ),
                  const SizedBox(width: Dimens.padding),
                  _ControlChip(
                    label: _filters.category,
                    iconPath: Assets.icons.filterSearch,
                    onTap: _openSheet,
                  ),
                  const Spacer(),
                  Text(
                    '${products.length} items',
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (products.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.gutter),
                  child: Text(
                    'Nothing in that price range.',
                    style: context.text.bodyLarge?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.gutter,
                0,
                Dimens.gutter,
                Dimens.gutter,
              ),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimens.mediumPadding,
                      crossAxisSpacing: Dimens.mediumPadding,
                      mainAxisExtent: 268,
                    ),
                delegate: SliverChildBuilderDelegate(
                  childCount: products.length,
                  (BuildContext context, int index) => ProductCard(
                    product: products[index],
                    heroPrefix: 'grid',
                    index: index,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Pill that opens the sort-and-filter sheet and shows its current value.
class _ControlChip extends StatelessWidget {
  const _ControlChip({
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  final String label;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Material(
      color: colors.surfaceContainer,
      shape: AppShapes.pill,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.mediumPadding,
            vertical: Dimens.padding + 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppSvgViewer(iconPath, width: 15, color: colors.onSurfaceVariant),
              const SizedBox(width: Dimens.smallPadding),
              Text(label, style: context.text.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}
