import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../data/models/cart_item_model.dart';
import '../bloc/cart_cubit.dart';
import 'cart_actions.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Cart line items, each swipeable to remove.
///
/// Rows sit on their own tonal card rather than being separated by dividers, so
/// each item reads as a discrete object you can act on.
class CartListWidget extends StatelessWidget {
  const CartListWidget({required this.items, super.key});

  final List<CartItemModel> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        Dimens.gutter,
        Dimens.padding,
        Dimens.gutter,
        Dimens.padding,
      ),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: Dimens.mediumPadding),
      itemBuilder: (BuildContext context, int index) {
        final CartItemModel item = items[index];

        return Dismissible(
          key: ValueKey<int>(item.product.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) =>
              context.read<CartCubit>().removeItem(item.product.id),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: Dimens.largePadding),
            decoration: BoxDecoration(
              color: colors.errorContainer,
              borderRadius: AppShapes.radiusXl,
            ),
            child: Icon(
              Symbols.delete,
              size: 24,
              color: colors.onErrorContainer,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(Dimens.mediumPadding),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: AppShapes.radiusXl,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: AppShapes.radiusMd,
                  child: Image.asset(
                    item.product.imageUrl,
                    width: 84,
                    height: 84,
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
                      const SizedBox(height: 2),
                      Text(
                        '${item.product.weight.toStringAsFixed(1)} kg',
                        style: context.text.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: Dimens.mediumPadding),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '\$${item.totalPrice.toStringAsFixed(2)}',
                              style: AppTypography.price(16).copyWith(
                                color: context.semantics.priceAccent,
                              ),
                            ),
                          ),
                          CartActions(item: item),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
