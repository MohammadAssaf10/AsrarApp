import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../../auth/data/data_sources/firebase_auth_helper.dart';
import '../../../../auth/domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuthHelper _authHelper = instance<FirebaseAuthHelper>();
  UserBloc() : super(UserInitial()) {
    on<GetUserInfo>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await _authHelper.getUser(event.email);
        emit(UserLoadedState(user: user));
      } catch (e) {
        emit(
          UserErrorState(errorMessage: e.toString()),
        );
      }
    });
  }
}
