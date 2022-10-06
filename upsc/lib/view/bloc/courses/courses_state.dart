part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();
}

class CoursesInitial extends CoursesState {
  @override
  List<Object> get props => [];
}

class CoursesSuccess extends CoursesState {
  final List<CourseModel> courseList;

   CoursesSuccess({required this.courseList});
  @override
  List<Object> get props => [courseList];
}

class CoursesError extends CoursesState {
  @override
  List<Object> get props => [];
}
class CoursesLoading extends CoursesState {
  @override
  List<Object> get props => [];
}
