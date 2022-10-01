import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upsc/models/course_model.dart';
import 'package:upsc/services/courses_services.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';


part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial()) {
    CoursesService coursesService = CoursesService();
    var token = SharedPreferenceHelper.getString(Preferences.access_token);
    on<GetCourses>((event, emit) async{
      emit(CoursesLoading());
      try{
        if(token !=null){
          var response = await coursesService.getCourses(token,event.filter,event.type);
          if(response.data['status'] == true){
            var recordSnapshots = response.data['data'] as List;

            List<CourseModel> dataList = [];
            for(var data in recordSnapshots){
              dataList.add(CourseModel.fromJson(data));
            }
            emit(CoursesSuccess(courseList: dataList));
          }
          else{
            emit(CoursesError());
          }
        }
        else{
          emit(CoursesError());
        }
      }catch(error){
        emit(CoursesError());
      }
    });
  }
}
