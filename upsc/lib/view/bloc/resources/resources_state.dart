part of 'resources_bloc.dart';

abstract class ResourcesState extends Equatable {
  const ResourcesState();
}

class ResourcesInitial extends ResourcesState {
  @override
  List<Object> get props => [];
}

class ResourcesSuccess extends ResourcesState{
  final ResourcesModel resources;
  const ResourcesSuccess({required this.resources});
  @override
  List<Object?> get props => [resources];
}

class ResourcesError extends ResourcesState{
  @override
  List<Object?> get props => [];
}

class ResourcesLoading extends ResourcesState{
  @override
  List<Object?> get props => [];
}