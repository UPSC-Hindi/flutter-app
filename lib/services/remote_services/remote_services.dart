import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class RemoteServices {
  static Future<dynamic> getBannerApi() async {
    try {
      dynamic response = await BaseClient.get(url: Api.baseUrl + Api.getBanner);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getStreamService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Api.baseUrl + Api.getCategoryStream);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<dynamic> getOrderIdService(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.getOrderId, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
