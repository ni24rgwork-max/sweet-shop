import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/widgets/app_title_widget.dart';
import '../../../cart_feature/data/data_source/local/fake_products.dart';
import '../../../cart_feature/data/models/product_model.dart';
import '../../data/data_source/local/sample_data.dart';
import 'product_card.dart';

/// The stacked "Featured / New / Popular" product rails on the home tab.
///
/// Each rail draws from [FakeProducts] rather than the parallel name/image string
/// lists the original used, so a card can hand a real [ProductModel] to the
/// details route instead of the screen re-deriving it from sample data.
class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  /// Rotates the product order per rail so the three rails do not show an
  /// identical sequence.
  List<ProductModel> _railFor(int index) {
    final List<ProductModel> all = FakeProducts.products;
    final int offset = (index * 3) % all.length;
    return <ProductModel>[...all.sublist(offset), ...all.sublist(0, offset)];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < titleOfTheListOfProducts.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(height: Dimens.veryLargePadding),
          AppTitleWidget(
            title: titleOfTheListOfProducts[i],
            onPressed: () => context.push(Routes.products),
          ),
          const SizedBox(height: Dimens.mediumPadding),
          SizedBox(
            height: 268,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.gutter),
              itemCount: 6,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: Dimens.mediumPadding),
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  product: _railFor(i)[index],
                  heroPrefix: 'rail$i',
                  index: index,
                  width: 172,
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
