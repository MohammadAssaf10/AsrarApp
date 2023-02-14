import '../../../auth/domain/entities/user.dart';
import 'product_entities.dart';

class ShopOrderEntities {
  final int shopOrderId;
  final User user;
  final String phoneNumber;
  final List<ProductEntities> products;
  final String totalPrice;
  String orderStatus;
  ShopOrderEntities({
    required this.shopOrderId,
    required this.user,
    required this.phoneNumber,
    required this.products,
    required this.totalPrice,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopOrderId': shopOrderId,
      'user': user.toMap(),
      'phoneNumber': phoneNumber,
      'products': products.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderStatus': orderStatus,
    };
  }

  factory ShopOrderEntities.fromMap(Map<String, dynamic> map) {
    return ShopOrderEntities(
      shopOrderId: map['shopOrderId'],
      user: User.fromMap(map['user']),
      phoneNumber: map['phoneNumber'],
      products: List<ProductEntities>.from(
          map['products']?.map((x) => ProductEntities.fromMap(x))),
      totalPrice: map['totalPrice'],
      orderStatus: map['orderStatus'],
    );
  }
  @override
  String toString() {
    return 'ShopOrderEntities(shopOrderId: $shopOrderId, user: $user, phoneNumber: $phoneNumber, products: $products, totalPrice: $totalPrice, orderStatus: $orderStatus)';
  }
}
