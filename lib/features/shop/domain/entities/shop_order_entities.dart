import '../../../auth/domain/entities/user.dart';
import 'product_entities.dart';

class ShopOrderEntities {
  final int shopOrderId;
  final User user;
  final String phoneNumber;
  final List<ProductEntities> products;
  final int totalPrice;
  final String orderStatus;
  final String chargeId;
  ShopOrderEntities({
    required this.shopOrderId,
    required this.user,
    required this.phoneNumber,
    required this.products,
    required this.totalPrice,
    required this.orderStatus,
    required this.chargeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopOrderId': shopOrderId,
      'user': user.toMap(),
      'phoneNumber': phoneNumber,
      'products': products.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderStatus': orderStatus,
      'chargeId': chargeId,
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
      chargeId: map['chargeId'],
    );
  }
  @override
  String toString() {
    return 'ShopOrderEntities(shopOrderId: $shopOrderId, user: $user, phoneNumber: $phoneNumber, products: $products, totalPrice: $totalPrice, orderStatus: $orderStatus, chargeId: $chargeId)';
  }

  ShopOrderEntities copyWith({
    int? shopOrderId,
    User? user,
    String? phoneNumber,
    List<ProductEntities>? products,
    int? totalPrice,
    String? orderStatus,
    String? chargeId,
  }) {
    return ShopOrderEntities(
      shopOrderId: shopOrderId ?? this.shopOrderId,
      user: user ?? this.user,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      orderStatus: orderStatus ?? this.orderStatus,
      chargeId: chargeId ?? this.chargeId,
    );
  }
}
