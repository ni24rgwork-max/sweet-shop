import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/rate_widget.dart';
import '../../../cart_feature/data/models/product_model.dart';
import '../../../cart_feature/presentation/bloc/cart_cubit.dart';
import '../../data/product_details_args.dart';

/// A product tile, used by the home rails, the products grid and search results.
///
/// The image carries a [Hero] tag so opening the details screen animates the
/// photo into place rather than cross-fading two unrelated screens. The tag is
/// derived from the product id plus a caller-supplied [heroPrefix], because the
/// same product can appear in more than one rail on a single screen and Hero
/// requires tags to be unique within a route.
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.heroPrefix,
    required this.index,
    super.key,
    this.width,
  });

  final ProductModel product;
  final String heroPrefix;

  /// Position within its rail or grid. Part of the hero tag so uniqueness is
  /// structural rather than dependent on product ids being distinct — which they
  /// were not: the sample data shipped two products sharing id 7.
  final int index;

  final double? width;

  String get heroTag => '$heroPrefix-$index-${product.id}';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SizedBox(
      width: width,
      child: Card(
        color: colors.surfaceContainerLow,
        child: InkWell(
          onTap: () => context.push(
            Routes.productDetails,
            extra: ProductDetailsArgs(product: product, heroTag: heroTag),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.18,
                    child: Hero(
                      tag: heroTag,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Dimens.padding,
                    left: Dimens.padding,
                    child: RateWidget(
                      rate: product.rate.toStringAsFixed(1),
                      pill: true,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.mediumPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${product.weight.toStringAsFixed(1)} kg',
                      style: context.text.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: Dimens.mediumPadding),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTypography.price(16).copyWith(
                              color: context.semantics.priceAccent,
                            ),
                          ),
                        ),
                        _AddButton(product: product),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SizedBox.square(
      dimension: 34,
      child: IconButton(
        onPressed: () {
          context.read<CartCubit>().addItem(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} added to cart'),
              duration: const Duration(milliseconds: 1400),
            ),
          );
        },
        style: IconButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: AppShapes.pill,
          padding: EdgeInsets.zero,
        ),
        icon: Icon(Symbols.add_rounded, size: 20, color: colors.onPrimary),
      ),
    );
  }
}
