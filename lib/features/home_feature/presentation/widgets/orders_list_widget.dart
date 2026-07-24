import 'package:flutter/material.dart';

import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../cart_feature/data/data_source/local/fake_products.dart';
import '../../../cart_feature/data/models/product_model.dart';

enum OrderType { active, completed, canceled }

/// Order history for one tab of the orders screen.
///
/// Each order carries a status pill in the semantic colour for its state, and the
/// action is a tonal button rather than three differently-coloured filled buttons
/// competing for attention down the list.
class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({required this.orderType, super.key});

  final OrderType orderType;

  String get _actionLabel => switch (orderType) {
    OrderType.active => 'Track order',
    OrderType.completed => 'Order again',
    OrderType.canceled => 'Order again',
  };

  String get _statusLabel => switch (orderType) {
    OrderType.active => 'On the way',
    OrderType.completed => 'Delivered',
    OrderType.canceled => 'Cancelled',
  };

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final AppSemantics semantics = context.semantics;

    final (Color statusFg, Color statusBg) = switch (orderType) {
      OrderType.active => (semantics.warning, semantics.warningContainer),
      OrderType.completed => (semantics.success, semantics.successContainer),
      OrderType.canceled => (colors.error, colors.errorContainer),
    };

    final List<ProductModel> orders = FakeProducts.products;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        Dimens.gutter,
        Dimens.mediumPadding,
        Dimens.gutter,
        // Clears the floating navigation bar.
        108,
      ),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: Dimens.mediumPadding),
      itemBuilder: (BuildContext context, int index) {
        final ProductModel product = orders[index];
        final int quantity = index + 2;

        return Container(
          padding: const EdgeInsets.all(Dimens.mediumPadding),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: AppShapes.radiusXl,
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: AppShapes.radiusMd,
                    child: Image.asset(
                      product.imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: Dimens.mediumPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                product.name,
                                style: context.text.titleSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.padding,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: AppShapes.radiusXs,
                              ),
                              child: Text(
                                _statusLabel,
                                style: context.text.labelSmall?.copyWith(
                                  color: statusFg,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$quantity pcs · order #${1200 + product.id}',
                          style: context.text.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: Dimens.padding),
                        Text(
                          '\$${(product.price * quantity).toStringAsFixed(2)}',
                          style: AppTypography.price(16).copyWith(
                            color: semantics.priceAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.mediumPadding),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  child: Text(_actionLabel),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
