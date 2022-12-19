import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class ResourceServices {
  Future<dynamic> dailyNewsService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getDailyNews);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getNotesService(dynamic queryParameters) async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getNotes,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getYouTubeVideoService() async {
    try {
      var response =
          await BaseClient.get(url: Api.baseUrl + Api.getYouTubeVideo);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAirREsourceService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getAirResources);

      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> getCourseIndexService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getCourseIndex);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
