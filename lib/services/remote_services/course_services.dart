import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class CourseServices {
  Future<dynamic> getCourses(dynamic queryParameters) async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getCourses,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
