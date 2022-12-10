part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesError extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CartCourseAddSuccess extends CoursesState {}

class DeleteCartCourses extends CoursesState {}
