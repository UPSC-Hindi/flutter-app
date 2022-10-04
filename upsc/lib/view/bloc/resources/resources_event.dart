part of 'resources_bloc.dart';

abstract class ResourcesEvent extends Equatable {
  const ResourcesEvent();
}

class GetResources extends ResourcesEvent {
  final String? filter;
  const GetResources({this.filter});
  @override
  List<Object?> get props => [];
}
