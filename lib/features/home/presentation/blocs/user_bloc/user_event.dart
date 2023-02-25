part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserInfo extends UserEvent {
  final String id;
  const GetUserInfo({required this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateUserImageEvent extends UserEvent {
  final User user;
  final XFile image;
  const UpdateUserImageEvent({required this.user, required this.image});
  @override
  List<Object?> get props => [user, image];
}

class UpdatePasswordEvent extends UserEvent {
  final String newPassword;
  const UpdatePasswordEvent({required this.newPassword});
  @override
  List<Object?> get props => [newPassword];
}

class UpdateUserInfo extends UserEvent {
  final User oldUser;
  final String newEmail;
  final String newName;
  final String newPhoneNumber;
  const UpdateUserInfo(
      {required this.oldUser,
      required this.newEmail,
      required this.newName,
      required this.newPhoneNumber});
  @override
  List<Object?> get props => [oldUser, newEmail, newName, newPhoneNumber];
}
