import 'package:flutter/foundation.dart';

/// A single item in the catalogue.
///
/// Value type: two products with the same fields compare equal, which keeps
/// list diffing and `Set` de-duplication honest.
@immutable
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.rate,
    required this.imageUrl,
  });

  final int id;
  final String name;

  /// Price in the store's display currency.
  final double price;

  /// Weight in kilograms.
  final double weight;

  /// Average customer rating, 0–5.
  final double rate;

  final String imageUrl;

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    double? weight,
    double? rate,
    String? imageUrl,
  }) => ProductModel(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    weight: weight ?? this.weight,
    rate: rate ?? this.rate,
    imageUrl: imageUrl ?? this.imageUrl,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          other.id == id &&
          other.name == name &&
          other.price == price &&
          other.weight == weight &&
          other.rate == rate &&
          other.imageUrl == imageUrl;

  @override
  int get hashCode => Object.hash(id, name, price, weight, rate, imageUrl);

  @override
  String toString() => 'ProductModel(id: $id, name: $name)';
}
