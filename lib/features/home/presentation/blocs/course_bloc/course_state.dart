part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
}

class CourseInitial extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoadingState extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseErrorState extends CourseState {
  final String errorMessage;
  const CourseErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CourseLoadedState extends CourseState {
  final List<CourseEntities> courseList;
  const CourseLoadedState({required this.courseList});
  @override
  List<Object?> get props => [courseList];
}
