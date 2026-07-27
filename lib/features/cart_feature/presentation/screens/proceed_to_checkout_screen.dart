import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../bloc/cart_cubit.dart';
import '../widgets/orders_list_for_checkout.dart';
import '../widgets/payment_details_item.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Checkout review.
///
/// Grouped into three labelled cards — costs, address, items — instead of one
/// undifferentiated column, and the figures are computed from the cart rather
/// than hardcoded.
class ProceedToCheckoutScreen extends StatelessWidget {
  const ProceedToCheckoutScreen({super.key});

  static const double _delivery = 10;
  static const double _discount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'Checkout'),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (BuildContext context, CartState state) {
          final double subtotal = state is CartLoaded ? state.totalAmount : 0;
          final double total = subtotal + _delivery - _discount;

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              Dimens.gutter,
              Dimens.padding,
              Dimens.gutter,
              Dimens.gutter,
            ),
            children: <Widget>[
              _Section(
                title: 'Payment details',
                child: Column(
                  children: <Widget>[
                    PaymentDetailsItem(
                      title: 'Subtotal',
                      subtitle: '\$${subtotal.toStringAsFixed(2)}',
                    ),
                    PaymentDetailsItem(
                      title: 'Delivery',
                      subtitle: '\$${_delivery.toStringAsFixed(2)}',
                    ),
                    PaymentDetailsItem(
                      title: 'Discount',
                      subtitle: '-\$${_discount.toStringAsFixed(2)}',
                    ),
                    const Divider(),
                    PaymentDetailsItem(
                      title: 'Total',
                      subtitle: '\$${total.toStringAsFixed(2)}',
                      emphasised: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimens.largePadding),
              _Section(
                title: 'Delivery address',
                action: TextButton(
                  onPressed: () => context.push(Routes.changeAddress),
                  child: const Text('Change'),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Symbols.location_on,
                      size: 20,
                      color: context.colors.primary,
                    ),
                    const SizedBox(width: Dimens.mediumPadding),
                    Expanded(
                      child: Text(
                        'Montgomery Street, Country Street East Pkwy',
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimens.largePadding),
              const _Section(
                title: 'Your order',
                child: OrdersListForCheckout(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.padding,
          Dimens.gutter,
          Dimens.mediumPadding,
        ),
        child: FilledButton(
          onPressed: () => context.push(Routes.paymentMethods),
          child: const Text('Continue to payment'),
        ),
      ),
    );
  }
}

/// Titled card wrapper used by each block on this screen.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(Dimens.mediumPadding),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppShapes.radiusXl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(title, style: context.text.titleMedium)),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: Dimens.padding),
          child,
        ],
      ),
    );
  }
}
