part of 'api_bloc.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();
}

class GetCartDetails extends ApiEvent {
  @override
  List<Object?> get props => [];
}

class GetMyCourses extends ApiEvent {
  @override
  List<Object?> get props => [];
}

class GetCourses extends ApiEvent {
  final String filter;
  final String type;
  const GetCourses({required this.type,required this.filter});
  @override
  List<Object?> get props => [];
}