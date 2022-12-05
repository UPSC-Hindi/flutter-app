

import 'package:upsc_web/features/model/courses_model/CoursesModel.dart';
import 'package:upsc_web/services/remote_services/course_services.dart';
import 'package:upsc_web/utils/utils.dart';

class CoursesController{
  CourseServices courseServices = CourseServices();
  Future<CoursesModel>getCourses(dynamic value)async{
    try{
      dynamic response = await courseServices.getCourses({"exam_type":value});
      return CoursesModel.fromJson(response);
    }catch(error){
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }
}