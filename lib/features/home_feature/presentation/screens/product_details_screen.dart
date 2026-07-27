import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_bordered_icon_button.dart';
import '../../../../core/widgets/app_choice_chip.dart';
import '../../../../core/widgets/app_icon_buttons.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../../../core/widgets/rate_widget.dart';
import '../../../cart_feature/data/data_source/local/fake_products.dart';
import '../../../cart_feature/data/models/product_model.dart';
import '../../../cart_feature/presentation/bloc/cart_cubit.dart';
import '../../data/data_source/local/sample_data.dart';
import '../../data/product_details_args.dart';
import '../widgets/user_profile_image.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Product details.
///
/// Restructured around a [CustomScrollView]: the photograph is a collapsing
/// [SliverAppBar] that the content sheet slides over, and the price plus
/// call-to-action are pinned to the bottom so they stay reachable at any scroll
/// offset. The previous version nested a fixed-height `Stack` inside a `SizedBox`
/// sized from the viewport, which clipped on short screens.
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.args});

  /// Supplied by the card that opened this screen. Falls back to sample data when
  /// the route is entered directly.
  final ProductDetailsArgs? args;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String _selectedWeight = weights[2];

  ProductModel get _product =>
      widget.args?.product ?? FakeProducts.products.first;

  void _addToCart() {
    context.read<CartCubit>().addItem(_product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_product.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _PhotoHeader(product: _product, heroTag: widget.args?.heroTag),

          SliverToBoxAdapter(
            child: Container(
              // Pulls the sheet up over the photo so the two overlap.
              transform: Matrix4.translationValues(0, -Dimens.largePadding, 0),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppShapes.hero),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(
                Dimens.gutter,
                Dimens.veryLargePadding,
                Dimens.gutter,
                Dimens.largePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _product.name,
                          style: context.text.headlineMedium,
                        ),
                      ),
                      const SizedBox(width: Dimens.mediumPadding),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.smallPadding),
                        child: RateWidget(
                          rate: _product.rate.toStringAsFixed(1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.mediumPadding),
                  AppReadMoreText(productDescription),

                  const SizedBox(height: Dimens.largePadding),
                  Text('Select weight', style: context.text.titleMedium),
                  const SizedBox(height: Dimens.mediumPadding),
                  Wrap(
                    spacing: Dimens.padding,
                    runSpacing: Dimens.padding,
                    children: <Widget>[
                      for (final String weight in weights)
                        AppChoiceChip(
                          label: weight,
                          selected: _selectedWeight == weight,
                          onSelected: (_) =>
                              setState(() => _selectedWeight = weight),
                        ),
                    ],
                  ),

                  const SizedBox(height: Dimens.largePadding),
                  const Divider(),
                  const SizedBox(height: Dimens.padding),
                  Text('Baker', style: context.text.titleMedium),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox.square(
                      dimension: 46,
                      child: UserProfileImage(
                        imagePath: Assets.images.profileImage.path,
                      ),
                    ),
                    title: Text('Luna Fisher', style: context.text.titleSmall),
                    subtitle: Text(
                      'Cakes & pastries',
                      style: context.text.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    trailing: AppIconButton(
                      icon: Symbols.call,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _CheckoutBar(
        product: _product,
        onAddToCart: _addToCart,
      ),
    );
  }
}

/// Collapsing product photograph.
class _PhotoHeader extends StatelessWidget {
  const _PhotoHeader({required this.product, this.heroTag});

  final ProductModel product;

  /// Null when the route was entered directly, in which case there is no source
  /// card to fly from and the photo simply fades in with the page.
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      stretch: true,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 76,
      // Centred so the toolbar cannot stretch the circular buttons into
      // ellipses — see the same note in GeneralAppBar.
      leading: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: Dimens.gutter),
          child: AppBorderedIconButton(
            icon: Symbols.arrow_back,
            onPressed: () => context.pop(),
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: AppBorderedIconButton(
            icon: Symbols.favorite,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: Dimens.gutter),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (heroTag != null)
              Hero(
                tag: heroTag!,
                child: Image.asset(product.imageUrl, fit: BoxFit.cover),
              )
            else
              Image.asset(product.imageUrl, fit: BoxFit.cover),
            // Keeps the back and favourite buttons legible over a bright photo.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    colors.surface.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.transparent,
                    colors.surface.withValues(alpha: 0.55),
                  ],
                  stops: const <double>[0, 0.28, 0.6, 1],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pinned price and call-to-action.
class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.product, required this.onAddToCart});

  final ProductModel product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.mediumPadding,
          Dimens.gutter,
          Dimens.mediumPadding,
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Total',
                  style: context.text.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTypography.price(24).copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(width: Dimens.largePadding),
            Expanded(
              child: FilledButton(
                onPressed: onAddToCart,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Symbols.shopping_cart,
                      size: 20,
                      color: colors.onPrimary,
                    ),
                    const SizedBox(width: Dimens.mediumPadding),
                    const Text('Add to cart'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
