part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserInfo extends UserEvent {
  final String email;
  const GetUserInfo({required this.email});
  @override
  List<Object?> get props => [email];
}

class UpdateUserImageEvent extends UserEvent {
  final String email;
  final XFile image;
  const UpdateUserImageEvent({required this.email, required this.image});
  @override
  List<Object?> get props => [email, image];
}
