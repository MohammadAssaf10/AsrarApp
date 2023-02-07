part of 'ad_image_bloc.dart';

abstract class AdImageState extends Equatable {
  const AdImageState();
}

class AdImageInitial extends AdImageState {
  @override
  List<Object> get props => [];
}

class AdImagesLoadedState extends AdImageState {
  final List<AdImageEntities> adImagelist;

  const AdImagesLoadedState({required this.adImagelist});

  @override
  List<Object?> get props => [adImagelist];
}

class AdImageLoadingState extends AdImageState {
  @override
  List<Object?> get props => [];
}

class AdImageErrorState extends AdImageState {
  final String errorMessage;

  const AdImageErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
