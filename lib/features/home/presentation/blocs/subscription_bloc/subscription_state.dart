part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
}

class SubscriptionInitial extends SubscriptionState {
  @override
  List<Object?> get props => [];
}

class SubscriptionLoadingState extends SubscriptionState {
  @override
  List<Object?> get props => [];
}

class SubscriptionErrorState extends SubscriptionState {
  final String errorMessage;
  SubscriptionErrorState({
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [errorMessage];
}

class SubscriptionsLoadedState extends SubscriptionState {
  final List<SubscriptionEntities> subscriptionList;
  SubscriptionsLoadedState({
    required this.subscriptionList,
  });
  @override
  List<Object?> get props => [subscriptionList];
}
