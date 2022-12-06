import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/features/model/courses_model/CoursesModel.dart';
import 'package:upsc_web/features/model/courses_model/course_detailsModel.dart';
import 'package:upsc_web/services/remote_services/course_services.dart';
import 'package:upsc_web/utils/utils.dart';

class CoursesController {
  CourseServices courseServices = CourseServices();

  Future<CoursesModel> getCourses(dynamic value) async {
    try {
      dynamic response = await courseServices.getCourses({"exam_type": value});
      return CoursesModel.fromJson(response);
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<CoursesDetailsModel>getCoursesDetails(String courseId) async {
    try {
      dynamic response =
          await courseServices.getCoursesDetails({'batch_id': courseId});
      return CoursesDetailsModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> addCoursesToCart({required String courseId}) async {
    try {
      dynamic response =
          await courseServices.addCoursesToCart({'batch_id': courseId});
      BaseModel data = BaseModel.fromJson(response);
      Utils.flutterToast(data.msg);
      return data.status;
    } catch (error) {
      Utils.flutterToast(error.toString());
      return false;
    }
  }
}
