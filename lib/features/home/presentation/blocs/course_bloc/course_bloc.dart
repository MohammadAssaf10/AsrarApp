import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/course_entities.dart';
import '../../../domain/use_cases/get_courses.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesUseCase getNewsUseCase = GetCoursesUseCase();
  CourseBloc() : super(CourseInitial()) {
    on<GetCoursesListEvent>((event, emit) async {
      emit(CourseLoadingState());
      (await getNewsUseCase()).fold((failure) {
        emit(CourseErrorState(errorMessage: failure.message));
      }, (courseList) {
        emit(CourseLoadedState(courseList: courseList));
      });
    });
  }
}
