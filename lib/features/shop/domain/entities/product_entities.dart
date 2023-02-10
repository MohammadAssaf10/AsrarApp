class ProductEntities {
  final String productName;
  final String productImageUrl;
  final String productImageName;
  final String productPrice;
  int productCount;
  ProductEntities({
    required this.productName,
    required this.productImageUrl,
    required this.productImageName,
    required this.productPrice,
    this.productCount = 1,
  });

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
    return 'ProductEntities(productName: $productName, productImageUrl: $productImageUrl, productImageName: $productImageName, productPrice: $productPrice, productCount: $productCount)';
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productImageUrl': productImageUrl,
      'productImageName': productImageName,
      'productPrice': productPrice,
      'productCount': productCount,
    };
  }
}
