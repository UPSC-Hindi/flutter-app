part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesError extends CoursesController {}
class CoursesLoading extends CoursesController {}
class CartCourseAddSuccess extends CoursesController {}
