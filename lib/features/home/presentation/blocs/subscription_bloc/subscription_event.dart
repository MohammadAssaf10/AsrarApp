part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}

class GetSubscriptionsEvent extends SubscriptionEvent {
  @override
  List<Object?> get props => [];
}
