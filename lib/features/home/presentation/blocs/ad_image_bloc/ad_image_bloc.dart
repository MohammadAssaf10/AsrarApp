import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/ad_image_entities.dart';
import '../../../domain/use_cases/get_ad_image.dart';

part 'ad_image_event.dart';

part 'ad_image_state.dart';

class AdImageBloc extends Bloc<AdImageEvent, AdImageState> {
  final GetAdImageUseCase getAdImageUseCase = GetAdImageUseCase();
  AdImageBloc() : super(AdImageInitial()) {
    on<AdImageEvent>((event, emit) async {
      if (event is GetAdImages) {
        emit(AdImageLoadingState());
        (await getAdImageUseCase()).fold((failure) {
          emit(AdImageErrorState(errorMessage: failure.message));
        }, (adImagelist) {
          emit(AdImagesLoadedState(adImagelist: adImagelist));
        });
      }
    });
  }
}
