import 'package:flutter_test/flutter_test.dart';
import 'package:sweet_shop/features/cart_feature/data/models/product_model.dart';
import 'package:sweet_shop/features/cart_feature/presentation/bloc/cart_cubit.dart';

ProductModel _product({required int id, double price = 100}) => ProductModel(
  id: id,
  name: 'Product $id',
  price: price,
  weight: 250,
  rate: 4.5,
  imageUrl: 'assets/images/placeholder.png',
);

CartLoaded _loaded(CartCubit cubit) => cubit.state as CartLoaded;

void main() {
  group('CartCubit', () {
    late CartCubit cubit;

    setUp(() => cubit = CartCubit());
    tearDown(() => cubit.close());

    test('starts empty, before anything is loaded', () {
      expect(cubit.state, isA<CartInitial>());
      expect(cubit.isProductInCart(1), isFalse);
    });

    test('adding a product puts one line in the cart', () {
      cubit.addItem(_product(id: 1));

      final state = _loaded(cubit);
      expect(state.items, hasLength(1));
      expect(state.items.single.quantity, 1);
      expect(cubit.isProductInCart(1), isTrue);
    });

    test('adding the same product twice increments, it does not duplicate', () {
      cubit
        ..addItem(_product(id: 1))
        ..addItem(_product(id: 1));

      final state = _loaded(cubit);
      expect(state.items, hasLength(1), reason: 'same id must collapse to one line');
      expect(state.items.single.quantity, 2);
      expect(state.totalItems, 2);
    });

    test('totals sum price x quantity across every line', () {
      cubit
        ..addItem(_product(id: 1, price: 100))
        ..addItem(_product(id: 1, price: 100))
        ..addItem(_product(id: 2, price: 250));

      final state = _loaded(cubit);
      expect(state.totalItems, 3);
      expect(state.totalAmount, 450);
    });

    test('removeItem drops only the matching line', () {
      cubit
        ..addItem(_product(id: 1))
        ..addItem(_product(id: 2))
        ..removeItem(1);

      final state = _loaded(cubit);
      expect(state.items, hasLength(1));
      expect(state.items.single.product.id, 2);
      expect(cubit.isProductInCart(1), isFalse);
    });

    test('updateQuantity to zero or less removes the line entirely', () {
      cubit
        ..addItem(_product(id: 1))
        ..updateQuantity(1, 0);

      expect(_loaded(cubit).items, isEmpty);
    });

    test('decrementing the last unit removes the line', () {
      cubit
        ..addItem(_product(id: 1))
        ..decrementQuantity(1);

      expect(_loaded(cubit).items, isEmpty);
      expect(cubit.isProductInCart(1), isFalse);
    });

    test('decrementing above one keeps the line', () {
      cubit
        ..addItem(_product(id: 1))
        ..addItem(_product(id: 1))
        ..decrementQuantity(1);

      final state = _loaded(cubit);
      expect(state.items, hasLength(1));
      expect(state.items.single.quantity, 1);
    });

    test('quantity changes for an unknown product are a no-op', () {
      cubit
        ..addItem(_product(id: 1))
        ..incrementQuantity(999)
        ..decrementQuantity(999);

      expect(_loaded(cubit).totalItems, 1);
    });

    test('clearCart empties the cart and zeroes the totals', () {
      cubit
        ..addItem(_product(id: 1, price: 100))
        ..addItem(_product(id: 2, price: 250))
        ..clearCart();

      final state = _loaded(cubit);
      expect(state.items, isEmpty);
      expect(state.totalItems, 0);
      expect(state.totalAmount, 0);
    });

    test('line total is price x quantity', () {
      cubit
        ..addItem(_product(id: 1, price: 120))
        ..incrementQuantity(1);

      expect(_loaded(cubit).items.single.totalPrice, 240);
    });
  });
}
