part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();
}


class GetCourses extends CoursesEvent{
  final String filter;
  final String type;
  const GetCourses({required this.type,required this.filter});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}