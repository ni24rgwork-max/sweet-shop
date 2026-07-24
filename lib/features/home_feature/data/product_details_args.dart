import '../../cart_feature/data/models/product_model.dart';

/// What the details route needs from whoever opened it.
///
/// The hero tag travels with the product because [Hero] requires the source and
/// destination to agree on a tag, and the same product legitimately appears in
/// more than one rail. A tag derived only from the product id would collide
/// within a single route; one derived only at the destination could never match
/// the card that was tapped.
class ProductDetailsArgs {
  const ProductDetailsArgs({required this.product, required this.heroTag});

  final ProductModel product;
  final String heroTag;
}
