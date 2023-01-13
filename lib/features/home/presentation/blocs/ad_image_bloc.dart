import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/file_entities.dart';
import '../../domain/use_cases/get_file.dart';

part 'ad_image_event.dart';

part 'ad_image_state.dart';

class AdImageBloc extends Bloc<AdImageEvent, AdImageState> {
  final GetFileUseCase getFileUseCase;

  AdImageBloc({required this.getFileUseCase}) : super(AdImageInitial()) {
    on<AdImageEvent>((event, emit) async {
      if (event is GetAdImage) {
        emit(AdImageLoadingState());
        final fileUrl = await getFileUseCase("adImages");
        fileUrl.fold(
            (failure) => emit(AdImageErrorState(errorMessage: failure.message)),
            (imageUrlList) => emit(AdImageLoadedState(list: imageUrlList)));
      }
    });
  }
}
