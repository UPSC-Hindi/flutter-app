import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';

part 'resources_event.dart';
part 'resources_state.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  ResourcesBloc() : super(ResourcesInitial()) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    on<GetResources>((event, emit) async{
      try{
        var response = await remoteDataSourceImpl.getResources(event.key,event.value);
        print(response);
        if(response.status == true){
          emit(ResourcesSuccess(resources: response));
        }
        else{
          emit(ResourcesError());
        }
      }catch(error){
        emit(ResourcesError());
      }
    });
  }
}
