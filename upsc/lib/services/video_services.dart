import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';

class VideoServices {
  Future<Response> getVideo(String token) async {
    try {
      var response = await dioAuthorizationData(
      ).get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
