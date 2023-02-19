part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserErrorState extends UserState {
  final String errorMessage;
  const UserErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class UserLoadedState extends UserState {
  final User user;
  const UserLoadedState({required this.user});
  @override
  List<Object?> get props => [user];
}
