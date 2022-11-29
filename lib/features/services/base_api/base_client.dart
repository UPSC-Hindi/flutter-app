
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';

class BaseClient {
  Future<dynamic> get({required String url}) async {
    dynamic responseJson;
    try {
      final response =
          await Dio().get(url).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> post({required String url,dynamic data}) async {
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

  dynamic returnResponse(Response response) {
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
