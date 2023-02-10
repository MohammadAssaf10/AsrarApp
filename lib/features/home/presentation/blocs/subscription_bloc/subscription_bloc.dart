import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/subscription_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<SubscriptionEvent>((event, emit) async {
      emit(SubscriptionLoadingState());
      (await homeRepository.getSubscriptions()).fold((failure) {
        emit(SubscriptionErrorState(errorMessage: failure.message));
      }, (subscriptionList) {
        emit(SubscriptionsLoadedState(subscriptionList: subscriptionList));
      });
    });
  }
}
