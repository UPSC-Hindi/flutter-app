import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class SchedulerServices {
  Future<dynamic> getClassSchedulerService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getClassScheduler);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> getMySchedulerService(dynamic queryParameters) async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getMyScheduler,
          queryParameters: queryParameters,
          );
      print(response);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
