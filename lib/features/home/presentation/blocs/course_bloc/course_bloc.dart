import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/course_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final HomeRepository homeRepository = instance<HomeRepository>();
  CourseBloc() : super(CourseInitial()) {
    on<GetCoursesListEvent>((event, emit) async {
      emit(CourseLoadingState());
      (await homeRepository.getCourses()).fold((failure) {
        emit(CourseErrorState(errorMessage: failure.message));
      }, (courseList) {
        emit(CourseLoadedState(courseList: courseList));
      });
    });
  }
}
