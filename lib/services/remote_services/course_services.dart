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

  Future<dynamic> getCoursesDetailsService(dynamic queryParameters) async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getCoursesDetails + queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> addCoursesToCartServices(dynamic data) async {
    try {
      dynamic response = await BaseClient.post(
        url: Api.baseUrl + Api.addCoursesToCart,
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getMyCartCoursesServices() async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getCartCourses,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getMyCoursesServices() async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getMyCourses,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> deleteMyCartCoursesService(String cartId) async {
    try {
      dynamic response = await BaseClient.delete(
          url: Api.baseUrl + Api.deleteFromCart + cartId);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
