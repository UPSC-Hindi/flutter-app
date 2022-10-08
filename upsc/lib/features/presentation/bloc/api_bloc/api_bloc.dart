import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/models/course_model.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();

    on<GetCartDetails>((event, emit) async {
      try {
        var response = await remoteDataSourceImpl.getCartDetails();
        print(response.data);
        if (response.status) {
          emit(ApiCartDetailsSuccess(cartData: response.data));
        } else {
          emit(ApiError());
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
          emit(ApiError());
        }
      } catch (error) {
        emit(ApiError());
      }
    });

    on<GetCourses>((event, emit) async {
      emit(ApiLoading());
      try {
        var response =
            await remoteDataSourceImpl.getCourses(event.filter, event.type);
        print(response.data);
        if (response.status!) {
          emit(ApiCoursesSuccess(courseList: response.data!));
        } else {
          emit(ApiError());
        }
      } catch (error) {
        emit(ApiError());
      }
    });
  }
}
