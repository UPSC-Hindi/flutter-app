import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class RemoteServices {
  static Future<dynamic> getBannerApi(String? bannerType) async {
    try {
      dynamic queryParameters = {'BannerType': bannerType ?? 'APP'};
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.getBanner,
        queryParameters: queryParameters,
      );
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
