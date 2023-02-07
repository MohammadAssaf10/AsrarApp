import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/ad_image_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'ad_image_event.dart';

part 'ad_image_state.dart';

class AdImageBloc extends Bloc<AdImageEvent, AdImageState> {
  final HomeRepository homeRepository=instance<HomeRepository>();
  AdImageBloc() : super(AdImageInitial()) {
    on<AdImageEvent>((event, emit) async {
      if (event is GetAdImages) {
        emit(AdImageLoadingState());
        (await homeRepository.getAdImages()).fold((failure) {
          emit(AdImageErrorState(errorMessage: failure.message));
        }, (adImagelist) {
          emit(AdImagesLoadedState(adImagelist: adImagelist));
        });
      }
    });
  }
}
