import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/features/model/courses_model/CartCoursesModel.dart';
import 'package:upsc_web/features/model/courses_model/CoursesModel.dart';
import 'package:upsc_web/features/model/courses_model/MyCoursesModel.dart';
import 'package:upsc_web/features/model/courses_model/courseDetailsModel.dart';
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

  Future<CoursesDetailsModel> getCoursesDetails(String courseId) async {
    try {
      dynamic response =
          await courseServices.getCoursesDetailsService(courseId);
      return CoursesDetailsModel.fromJson(response);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<bool> addCoursesToCart({required String courseId}) async {
    try {
      Response response =
          await courseServices.addCoursesToCartServices({'batch_id': courseId});
      BaseModel data = BaseModel.fromJson(response.data);
      Utils.flutterToast(data.msg);
      return data.status;
    } catch (error) {
      Utils.toastMessage(error.toString());
      return false;
    }
  }

  Future<MyCartCoursesModel> getMyCartCourses() async {
    try {
      dynamic response = await courseServices.getMyCartCoursesServices();
      return MyCartCoursesModel.fromJson(response);
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool> deleteMyCartCourses(String cartId) async {
    try {
      Response responseJson =
          await courseServices.deleteMyCartCoursesService(cartId);
      BaseModel response = BaseModel.fromJson(responseJson.data);
      Utils.flutterToast(response.msg);
      return response.status;
    } catch (error) {
      Utils.toastMessage(error.toString());
      return false;
    }
  }

  Future<MyCoursesModel> getMyCourses() async {
    try {
      dynamic response = await courseServices.getMyCoursesServices();
      return MyCoursesModel.fromJson(response);
    } catch (error) {
      print(error.toString());
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }
}
