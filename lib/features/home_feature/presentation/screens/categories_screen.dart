import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/widgets/app_title_widget.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../../../cart_feature/data/data_source/local/fake_products.dart';
import '../../../cart_feature/data/models/product_model.dart';
import '../../data/data_source/local/sample_data.dart';
import '../widgets/product_card.dart';

/// Category browser — one horizontal rail per category.
///
/// Cards are the shared [ProductCard], so add-to-cart adds the product actually
/// shown. The original picked a random product from the sample list regardless of
/// which card you tapped.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  /// Deduplicated — the sample list repeats every category name twice.
  List<int> get _categoryIndices {
    final Set<String> seen = <String>{};
    final List<int> indices = <int>[];
    for (int i = 0; i < titlesOfCategories.length; i++) {
      if (seen.add(titlesOfCategories[i])) indices.add(i);
    }
    return indices;
  }

  @override
  Widget build(BuildContext context) {
    final List<int> categories = _categoryIndices;

    return Scaffold(
      appBar: const GeneralAppBar(title: 'Categories'),
      body: ListView.separated(
        padding: const EdgeInsets.only(
          top: Dimens.padding,
          bottom: Dimens.gutter,
        ),
        itemCount: categories.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: Dimens.veryLargePadding),
        itemBuilder: (BuildContext context, int index) {
          final int category = categories[index];
          final List<ProductModel> products = _productsFor(index);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTitleWidget(
                thumbnail: iconsOfCategories[category],
                title: titlesOfCategories[category],
                onPressed: () => context.push(Routes.products),
              ),
              const SizedBox(height: Dimens.mediumPadding),
              SizedBox(
                height: 268,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.gutter,
                  ),
                  itemCount: products.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: Dimens.mediumPadding),
                  itemBuilder: (BuildContext context, int i) => ProductCard(
                    product: products[i],
                    heroPrefix: 'cat$index',
                    index: i,
                    width: 172,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Rotates the product list per category so each rail differs.
  List<ProductModel> _productsFor(int index) {
    final List<ProductModel> all = FakeProducts.products;
    final int offset = (index * 2) % all.length;
    return <ProductModel>[...all.sublist(offset), ...all.sublist(0, offset)];
  }
}
