part of 'resources_bloc.dart';

abstract class ResourcesEvent extends Equatable {
  const ResourcesEvent();
}

class GetResources extends ResourcesEvent {
  final String key;
  final String value;
  const GetResources({required this.key,required this.value});
  @override
  List<Object?> get props => [];
}
