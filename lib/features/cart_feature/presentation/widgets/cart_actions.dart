import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/theme.dart';
import '../../data/models/cart_item_model.dart';
import '../bloc/cart_cubit.dart';

/// Quantity stepper.
///
/// One connected pill rather than two loose squares, so decrement, count and
/// increment read as a single control.
class CartActions extends StatelessWidget {
  const CartActions({required this.item, super.key});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;
    final CartCubit cart = context.read<CartCubit>();

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: AppShapes.radiusSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _StepperButton(
            icon: item.quantity > 1
                ? Symbols.remove_rounded
                : Symbols.delete_rounded,
            onTap: () => cart.decrementQuantity(item.product.id),
          ),
          SizedBox(
            width: 26,
            child: Text(
              '${item.quantity}',
              textAlign: TextAlign.center,
              style: AppTypography.price(14).copyWith(color: colors.onSurface),
            ),
          ),
          _StepperButton(
            icon: Symbols.add_rounded,
            onTap: () => cart.incrementQuantity(item.product.id),
            emphasised: true,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onTap,
    this.emphasised = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colors;

    return Material(
      color: emphasised ? colors.primary : Colors.transparent,
      borderRadius: AppShapes.radiusSm,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox.square(
          dimension: 32,
          child: Icon(
            icon,
            size: 17,
            color: emphasised ? colors.onPrimary : colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
