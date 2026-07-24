/// Route paths, in one place so call sites never hand-write a string.
abstract final class Routes {
  const Routes._();

  static const String splash = '/splash';

  // Shell branches — the five bottom-nav destinations.
  static const String home = '/';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String map = '/map';
  static const String profile = '/profile';

  // Pushed on top of the shell, so they cover the navigation bar.
  static const String products = '/products';
  static const String productDetails = '/product-details';
  static const String categories = '/categories';
  static const String specialOffers = '/special-offers';
  static const String checkout = '/checkout';
  static const String changeAddress = '/checkout/address';
  static const String paymentMethods = '/checkout/payment';
}
