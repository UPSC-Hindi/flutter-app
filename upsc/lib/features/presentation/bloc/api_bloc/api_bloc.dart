import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/data_sources/scheduler_data_source/scheduler_remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/my_scheduler_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/features/domain/reused_function.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/classschedule.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    final schedulerRemoteDataSourceImpl = SchedulerRemoteDataSourceImpl();

    on<GetCartDetails>((event, emit) async {
      try {
        var response = await remoteDataSourceImpl.getCartDetails();
        print(response.data);
        if (response.status) {
          emit(ApiCartDetailsSuccess(cartData: response.data));
        } else {
          loginRoute();
        }
      } catch (error) {
        print("Server Error");
        emit(ApiError());
      }
    });

    on<GetMyCourses>((event, emit) async {
      try {
        var response = await remoteDataSourceImpl.getMyCourses();
        if (response.status) {
          emit(ApiMyCoursesSuccess(myCourses: response.data));
        } else {
          loginRoute();
        }
      } catch (error) {
        print(error);
        emit(ApiError());
      }
    });

    on<GetCourses>((event, emit) async {
      emit(ApiLoading());
      try {
        CoursesModel response =
        await remoteDataSourceImpl.getCourses(event.key,event.value);
        print(response);
        if (response.status) {
          emit(ApiCoursesSuccess(courseList: response.data));
        } else {
          flutterToast(response.msg.toString());
          loginRoute();
        }
      } catch (error) {
        print(error);
        flutterToast(error.toString());
        emit(ApiError());
      }
    });

    on<GetmyClassSchedule>((event, emit) async {
      emit(ApiLoading());
      try {
        ClassSchedulermodel response =
        await remoteDataSourceImpl.getMyClassSchedule();
        print(response);
        if (response.status!) {
          emit(ApiGetMyclassSchedulerSucces(myclassschedulerList: response.data!));
        } else {
          flutterToast(response.msg.toString());
          loginRoute();
        }
      } catch (error) {
        print(error);
        flutterToast(error.toString());
        emit(ApiError());
      }
    });

    on<GetResources>((event, emit) async{
      emit(ApiLoading());
      try{
        ResourcesModel response = await remoteDataSourceImpl.getResources(event.key,event.value);
        print(response);
        if(response.status == true){
          emit(ApiResourcesSuccess(resources: response));
        }
        else{
          loginRoute();
        }
      }catch(error){
        emit(ApiError());
      }
    });
    on<GetYouTubeVideo>((event, emit) async{
      emit(ApiLoading());
      try{
        VideoModel videoData = await remoteDataSourceImpl.getYouTubeVideo();
        if(videoData.status){
          emit(ApiYoutubeVideoSuccess(videoList: videoData.data));
        }else{
          loginRoute();
        }

      }catch(error){
        emit(ApiError());
      }
    });
    on<GetMyScheduler>((event, emit) async{
      emit(ApiLoading());
      try{
        MySchedulerModel schedulerData = await schedulerRemoteDataSourceImpl.getSchedule();
        if(schedulerData.status){
          emit(ApiGetSchedulerSuccess(schedulerList: schedulerData.data));
        }else{
          loginRoute();
        }
      }catch(error){
        emit(ApiError());
      }
    });
  }
}