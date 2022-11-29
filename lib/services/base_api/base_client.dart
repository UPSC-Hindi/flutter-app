
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';
Dio dioAuthorizationData() {
  // var token = SharedPreferenceHelper.getString(Preferences.access_token);

  var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdHVkZW50SWQiOiI0NDY3NTg3MC02ZDlkLTExZWQtYjJlMC0xZjUxYzA4ODgzMWUiLCJpYXQiOjE2Njk3MTkxOTEsImV4cCI6MTY2OTgwNTU5MX0.ZgqAGSazzLMTzsoHAFI1pgckreNeBLd3CXo-YDNVfzQ';
  final dio = Dio();
  dio.options.headers["Accept"] =
  "application/json"; // config your dio headers globally
  dio.options.followRedirects = false;
  dio.options.connectTimeout = 75000; //5s
  dio.options.receiveTimeout = 3000;
  print('token in = $token');
  dio.options.headers["Authorization"] = "Bearer $token";
  return dio;
}

class BaseClient {
  static Future<dynamic> get({required String url}) async {
    dynamic responseJson;
    try {
      final response =
          await dioAuthorizationData().get(url).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet Connection');
    }
    return responseJson;
  }

  static Future<dynamic> post({required String url,dynamic data}) async {
    dynamic responseJson;
    try {
      final response =
      await Dio().post(url,data: data).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
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
        throw BadRequestException(message: response.data.toString());
      case 404:
        throw UnauthorisedException(message: response.data.toString());
      default:
        throw FetchDataException(
            message:
                'Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }
}
