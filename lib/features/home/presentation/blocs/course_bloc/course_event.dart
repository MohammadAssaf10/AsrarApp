part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class GetCoursesListEvent extends CourseEvent {
  @override
  List<Object?> get props => [];
}
