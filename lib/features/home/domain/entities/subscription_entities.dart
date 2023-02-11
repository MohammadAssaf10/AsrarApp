import 'package:equatable/equatable.dart';

class SubscriptionEntities extends Equatable {
  final String subscriptionName;
  final String subscriptionPrice;
  const SubscriptionEntities({
    required this.subscriptionName,
    required this.subscriptionPrice,
  });
  @override
  List<Object> get props => [subscriptionName, subscriptionPrice];

  factory SubscriptionEntities.fromMap(Map<String, dynamic> map) {
    return SubscriptionEntities(
      subscriptionName: map['subscriptionName'],
      subscriptionPrice: map['subscriptionPrice'],
    );
  }
  @override
  String toString() =>
      'SubscriptionEntities(subscriptionName: $subscriptionName, subscriptionPrice: $subscriptionPrice)';
}
