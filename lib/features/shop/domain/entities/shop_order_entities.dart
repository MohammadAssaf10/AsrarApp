import 'product_entities.dart';

class ShopOrderEntities {
  final int shopOrderId;
  final String email;
  final String phoneNumber;
  final List<ProductEntities> products;
  final String totalPrice;
  String orderStatus;
  ShopOrderEntities({
    required this.shopOrderId,
    required this.email,
    required this.phoneNumber,
    required this.products,
    required this.totalPrice,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopOrderId': shopOrderId,
      'email': email,
      'phoneNumber': phoneNumber,
      'products': products.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderStatus': orderStatus,
    };
  }

  factory ShopOrderEntities.fromMap(Map<String, dynamic> map) {
    return ShopOrderEntities(
      shopOrderId: map['shopOrderId'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      products: List<ProductEntities>.from(
          map['products']?.map((x) => ProductEntities.fromMap(x))),
      totalPrice: map['totalPrice'],
      orderStatus: map['orderStatus'],
    );
  }
  @override
  String toString() {
    return 'ShopOrderEntities(shopOrderId: $shopOrderId, email: $email, phoneNumber: $phoneNumber, products: $products, totalPrice: $totalPrice, orderStatus: $orderStatus)';
  }
}
