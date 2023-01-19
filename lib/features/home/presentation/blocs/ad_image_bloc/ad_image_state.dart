part of 'ad_image_bloc.dart';

abstract class AdImageState extends Equatable {
  const AdImageState();
}

class AdImageInitial extends AdImageState {
  @override
  List<Object> get props => [];
}

class AdImageLoadedState extends AdImageState {
  final List<FileEntities> list;

  const AdImageLoadedState({required this.list});

  @override
  List<Object?> get props => [list];
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
