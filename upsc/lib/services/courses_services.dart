
import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';


class CoursesService{
  Future<Response> getCourses(String filter,String type) async {
    try {
      var courseUrl = '${Apis.getCoursesFilter}?$type=$filter';
      var response = await dioAuthorizationData(
      ).get('${Apis.baseUrl}$courseUrl');

      print('${Apis.baseUrl}$courseUrl');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}