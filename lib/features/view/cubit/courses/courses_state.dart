part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesError extends CoursesController {}
class CousesLoading extends CoursesController {}