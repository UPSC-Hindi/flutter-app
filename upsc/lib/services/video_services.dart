import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../api/api.dart';
import '../features/data/const_data.dart';

class VideoServices {
  Future<Response> getVideo(String token) async {
    try {
      var response = await dioAuthorizationData(token
      ).get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
