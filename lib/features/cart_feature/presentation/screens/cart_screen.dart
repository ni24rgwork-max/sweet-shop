import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_svg_viewer.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../bloc/cart_cubit.dart';
import '../widgets/cart_list_widget.dart';

/// The cart tab.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'My cart', showBackIcon: false),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (BuildContext context, CartState state) {
          return switch (state) {
            CartInitial() => const Center(child: CircularProgressIndicator()),
            CartError(message: final String message) => Center(
              child: Text('Error: $message'),
            ),
            CartLoaded(items: final items) when items.isEmpty =>
              const _EmptyCart(),
            CartLoaded() => _LoadedCart(state: state),
          };
        },
      ),
    );
  }
}

class _LoadedCart extends StatelessWidget {
  const _LoadedCart({required this.state});

  final CartLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: CartListWidget(items: state.items)),
        _CartSummary(state: state),
      ],
    );
  }
}

/// Totals and the checkout action, pinned below the list.
class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.state});

  final CartLoaded state;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: AppShapes.sheetTop,
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(
          Dimens.gutter,
          Dimens.largePadding,
          Dimens.gutter,
          Dimens.mediumPadding,
        ),
        child: Column(
          children: <Widget>[
            _SummaryRow(
              label: '${state.totalItems} items',
              value: '\$${state.totalAmount.toStringAsFixed(2)}',
            ),
            const SizedBox(height: Dimens.padding),
            _SummaryRow(label: 'Delivery', value: 'Free', muted: true),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.mediumPadding),
              child: Divider(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Total', style: context.text.titleMedium),
                ),
                Text(
                  '\$${state.totalAmount.toStringAsFixed(2)}',
                  style: AppTypography.price(22).copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.largePadding),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.push(Routes.checkout),
                child: const Text('Proceed to checkout'),
              ),
            ),
            // Clears the floating navigation bar.
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.muted = false,
  });

  final String label;
  final String value;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: context.text.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: muted
              ? context.text.bodyMedium?.copyWith(
                  color: context.semantics.success,
                  fontWeight: FontWeight.w600,
                )
              : AppTypography.price(14).copyWith(color: colors.onSurface),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.gutter),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppSvgViewer(
                  Assets.icons.shoppingCart,
                  width: 36,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: Dimens.largePadding),
            Text('Your cart is empty', style: context.text.headlineSmall),
            const SizedBox(height: Dimens.padding),
            Text(
              'Add something sweet and it will show up here.',
              textAlign: TextAlign.center,
              style: context.text.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Dimens.largePadding),
            FilledButton.tonal(
              onPressed: () => context.go(Routes.home),
              child: const Text('Browse cakes'),
            ),
          ],
        ),
      ),
    );
  }
}
