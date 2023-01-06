import 'package:dio/dio.dart';
import 'package:upsc/api/app_exception.dart';
import 'package:upsc/features/data/remote/models/base_model.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

Dio dioAuthorizationData({String? token}) {
  if (token == 'N/A') token = null;
  var localToken = SharedPreferenceHelper.getString(Preferences.access_token);
  final dio = Dio();
  dio.options.headers["Accept"] =
      "application/json"; // config your dio headers globally
  dio.options.followRedirects = false;
  dio.options.connectTimeout = 85000; //5s
  dio.options.receiveTimeout = 4000;
  print('token in = ${token ?? localToken}');
  dio.options.headers["Authorization"] = "Bearer ${token ?? localToken}";
  return dio;
}

class BaseClient {
  static Future<dynamic> get(
      {required String url, String? token, dynamic queryParameters}) async {
    try {
      final response = await dioAuthorizationData(token: token)
          .get(url, queryParameters: queryParameters)
          .timeout(const Duration(seconds: 10));
      return response.data;
    } on DioError catch (error) {
      throw dioError(error.type, error);
    }
  }

  static Future<dynamic> post(
      {required String url, dynamic data, String? token}) async {
    try {
      final response = await dioAuthorizationData(token: token)
          .post(url, data: data)
          .timeout(const Duration(seconds: 10));
      return response;
    } on DioError catch (error) {
      print(error.type.toString());
      throw dioError(error.type, error);
    }
  }

  static Future<dynamic> put({required String url, dynamic data}) async {
    try {
      final response = await dioAuthorizationData()
          .put(url, data: data)
          .timeout(const Duration(seconds: 10));
      return response.data;
    } on DioError catch (error) {
      print(error.type.toString());
      throw dioError(error.type, error);
    }
  }

  static Future<dynamic> delete({required String url}) async {
    try {
      final response = await dioAuthorizationData()
          .delete(url)
          .timeout(const Duration(seconds: 10));
      return response;
    } on DioError catch (error) {
      print(error.type.toString());
      throw dioError(error.type, error);
    }
  }

  //Dio Error handling
  static dynamic dioError(DioErrorType errorType, DioError error) {
    switch (errorType) {
      case DioErrorType.connectTimeout:
        throw FetchDataException(message: 'No Internet Connection');

      case DioErrorType.sendTimeout:
        throw FetchDataException(message: "Send Time Out");

      case DioErrorType.receiveTimeout:
        throw FetchDataException(message: "Receive Time Out");

      case DioErrorType.response:
        throw returnResponse(error.response);

      case DioErrorType.cancel:
        throw FetchDataException(message: "Cancel Request");

      default:
        throw FetchDataException(message: errorType.name);
    }
  }

  //User defined error
  static dynamic returnResponse(dynamic response) {
    print("------- Return response http base client -------");
    print(response.data);
    BaseModel responseBody = BaseModel.fromJson(response.data);
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message: responseBody.msg);
      case 404:
        throw UnauthorisedException(message: responseBody.msg);
      default:
        throw FetchDataException(
            message:
                'Error occurred while communicating with server with status code ${responseBody.msg}');
    }
  }
}
