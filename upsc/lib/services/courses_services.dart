
import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';


class CoursesService{
  Future<Response> getCourses(String token,String filter,String type) async {
    try {
      var _courseUrl = '${Apis.getCoursesFilter}?$type=$filter';
      var response = await dioAuthorizationData(token
      ).get('${Apis.baseUrl}$_courseUrl');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}