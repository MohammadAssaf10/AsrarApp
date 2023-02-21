import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/shop_order_entities.dart';
import '../../../domain/repositories/shop_repository.dart';

part 'shop_order_event.dart';
part 'shop_order_state.dart';

class ShopOrderBloc extends Bloc<ShopOrderEvent, ShopOrderState> {
  final ShopRepository shopRepository = instance<ShopRepository>();
  ShopOrderBloc() : super(ShopOrderInitial()) {
    on<AddShopOrderEvent>((event, emit) async {
      emit(ShopOrderLoadingState());
      (await shopRepository.addShopOrder(event.shopOrder)).fold((failure) {
        emit(ShopOrderErrorState(errorMessage: failure.message));
      }, (r) {
        emit(ShopOrderAddedSuccessfullyState());
      });
    });
    on<GetShopOrderEvent>((event, emit) async {
      emit(ShopOrderLoadingState());
      (await shopRepository.getShopOrder(event.userId)).fold((failure) {
        emit(ShopOrderErrorState(errorMessage: failure.message));
      }, (shopOrderList) {
        emit(ShopOrderLoadedState(shopOrderList: shopOrderList));
      });
    });
    on<CancelShopOrderEvent>((event, emit) async {
      emit(CancelShopOrderLoadingState());
      (await shopRepository.cancelShopOrder(event.shopOrder)).fold((failure) {
        emit(CancelShopOrderErrorState(errorMessage: failure.message));
      }, (r) {
        emit(ShopOrderCancelledSuccessfullyState());
      });
    });
  }
}
