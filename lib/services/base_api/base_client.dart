
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';
Dio dioAuthorizationData({String? token}) {
  // var token = SharedPreferenceHelper.getString(Preferences.access_token);
  var localToken = '';
  final dio = Dio();
  dio.options.headers["Accept"] =
  "application/json"; // config your dio headers globally
  dio.options.followRedirects = false;
  dio.options.connectTimeout = 75000; //5s
  dio.options.receiveTimeout = 3000;
  print('token in = $token');
  dio.options.headers["Authorization"] = "Bearer ${token??localToken}";
  return dio;
}

class BaseClient {
  static Future<dynamic> get({required String url,String? token}) async {
    dynamic responseJson;
    try {
      final response =
          await dioAuthorizationData(token: token).get(url).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on DioError {
      throw FetchDataException(message: 'No Internet Connection');
    }
    return responseJson;
  }

  static Future<dynamic> post({required String url,dynamic data,String? token}) async {
    dynamic responseJson;
    try {
      final response =
      await dioAuthorizationData(token: token).post(url,data: data).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on DioError catch(error){
      print(error.response);
      returnResponse(error.response!);
      throw FetchDataException(message: 'No Internet Connection');
    }
    return responseJson;
  }

  static dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = response.data;
        return jsonResponse;
      case 400:
        throw BadRequestException(message: response.data['msg'].toString());
      case 404:
        throw UnauthorisedException(message: response.data['msg'].toString());
      default:
        throw FetchDataException(
            message:
                'Error occurred while communicating with server with status code ${response.data['msg']}');
    }
  }
}
