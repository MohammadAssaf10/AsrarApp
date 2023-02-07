part of 'ad_image_bloc.dart';

abstract class AdImageEvent extends Equatable {
  const AdImageEvent();
}
class GetAdImages extends AdImageEvent{
  @override
  List<Object?> get props => [];
}
