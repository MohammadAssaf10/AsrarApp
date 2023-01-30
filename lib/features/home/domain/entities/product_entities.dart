import 'package:equatable/equatable.dart';

class ProductEntities extends Equatable {
  final String productName;
  final String productImageUrl;
  final String productImageName;
  final String productPrice;
  const ProductEntities({
    required this.productName,
    required this.productImageUrl,
    required this.productImageName,
    required this.productPrice,
  });
  @override
  List<Object> get props =>
      [productName, productImageUrl, productPrice, productImageName];

  factory ProductEntities.fromMap(Map<String, dynamic> map) {
    return ProductEntities(
      productName: map['productName'],
      productImageUrl: map['productImageUrl'],
      productImageName: map['productImageName'],
      productPrice: map['productPrice'],
    );
  }

  @override
  String toString() {
    return 'ProductEntities(productName: $productName, productImageUrl: $productImageUrl, productImageName: $productImageName, productPrice: $productPrice)';
  }
}
