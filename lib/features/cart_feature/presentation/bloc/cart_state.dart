part of 'cart_cubit.dart';

/// States the cart can be in.
///
/// Sealed so a `switch` over a [CartState] is checked for exhaustiveness at
/// compile time — adding a case here surfaces every place that needs updating.
@immutable
sealed class CartState {
  const CartState();
}

/// Nothing added yet.
final class CartInitial extends CartState {
  const CartInitial();
}

/// The cart has contents; [totalAmount] and [totalItems] are derived from
/// [items] by the cubit so the UI never recomputes them.
final class CartLoaded extends CartState {
  const CartLoaded({
    required this.items,
    required this.totalAmount,
    required this.totalItems,
  });

  final List<CartItemModel> items;
  final double totalAmount;
  final int totalItems;

  CartLoaded copyWith({
    List<CartItemModel>? items,
    double? totalAmount,
    int? totalItems,
  }) => CartLoaded(
    items: items ?? this.items,
    totalAmount: totalAmount ?? this.totalAmount,
    totalItems: totalItems ?? this.totalItems,
  );
}

/// Something went wrong while mutating the cart.
final class CartError extends CartState {
  const CartError(this.message);

  final String message;
}
