import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app/di.dart';
import '../../../../auth/data/data_sources/firebase_auth_helper.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuthHelper _authHelper = instance<FirebaseAuthHelper>();
  final UserRepository userRepository = instance<UserRepository>();
  UserBloc() : super(UserInitial()) {
    on<GetUserInfo>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await _authHelper.getUser(event.email);
        emit(UserLoadedState(user: user));
      } catch (e) {
        emit(UserErrorState(errorMessage: e.toString()));
      }
    });
    on<UpdateUserImageEvent>((event, emit) async {
      emit(UserLoadingState());
      (await userRepository.updateUserImage(event.image, event.email)).fold(
          (failure) {
        emit(UserErrorState(errorMessage: failure.message));
      }, (r) {
        emit(ImageUpdatedSuccessfullyState());
      });
    });
    on<UpdatePasswordEvent>((event, emit) async {
      emit(PasswordUpdatedLoadingState());
      (await userRepository.updatePassword(event.newPassword))
          .fold((failure) {
            emit(PasswordUpdatedErrorState(errorMessage: failure.message));
          }, (r) {
            emit(PasswordUpdatedSuccessfullyState());
          });
    });
  }
}
