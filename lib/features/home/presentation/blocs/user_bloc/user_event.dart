part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}
class GetUserInfo extends UserEvent{
  final String email;
  const GetUserInfo({required this.email});
  @override
  List<Object?> get props => [email];
}
