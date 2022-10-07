part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();
}

class ApiInitial extends ApiState {
  @override
  List<Object> get props => [];
}


class ApiLoading extends ApiState{
  @override
  List<Object?> get props => [];
}

class ApiError extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiCartDetailsSuccess extends ApiState{
  final List<CartDataModel> cartData;
  const ApiCartDetailsSuccess({required this.cartData});
  @override
  List<Object?> get props => [cartData];
}

class ApiMyCoursesSuccess extends ApiState{
  final List<MyCoursesDataModel> myCourses;
  const ApiMyCoursesSuccess({required this.myCourses});
  @override
  List<Object?> get props => [myCourses];
}

class ApiCoursesSuccess extends ApiState{
  final List<CourseDataModel> courseList;
  const ApiCoursesSuccess({required this.courseList});
  @override
  List<Object?> get props => [courseList];
}