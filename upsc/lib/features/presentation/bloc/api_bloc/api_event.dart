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
  final String value;
  final String key;
  const GetCourses({required this.key,required this.value});
  @override
  List<Object?> get props => [value,key];
}

class GetResources extends ApiEvent {
  final String key;
  final String value;
  const GetResources({required this.key,required this.value});

  @override
  List<Object?> get props => [key,value];
}
