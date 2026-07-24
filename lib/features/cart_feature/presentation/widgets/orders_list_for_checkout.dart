import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../data/models/cart_item_model.dart';
import '../bloc/cart_cubit.dart';

/// Read-only summary of what is being ordered.
///
/// Reads the actual cart rather than the sample image list, so the checkout
/// summary matches the cart the user just came from.
class OrdersListForCheckout extends StatelessWidget {
  const OrdersListForCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, CartState state) {
        final List<CartItemModel> items = state is CartLoaded
            ? state.items
            : const <CartItemModel>[];

        if (items.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.largePadding),
            child: Text(
              'No items yet.',
              style: context.text.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          );
        }

        return Column(
          children: <Widget>[
            for (final CartItemModel item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.mediumPadding),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: AppShapes.radiusSm,
                      child: Image.asset(
                        item.product.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: Dimens.mediumPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.product.name,
                            style: context.text.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${item.quantity} × '
                            '\$${item.product.price.toStringAsFixed(2)}',
                            style: context.text.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: AppTypography.price(14).copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
