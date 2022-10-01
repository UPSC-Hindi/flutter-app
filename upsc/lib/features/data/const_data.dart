

import 'package:dio/dio.dart';

Dio dioAuthorizationData(String token) {
  final dio = Dio();
  dio.options.headers["Accept"] =
  "application/json"; // config your dio headers globally
  dio.options.followRedirects = false;
  dio.options.connectTimeout = 75000; //5s
  dio.options.receiveTimeout = 3000;
  print('token in =$token');
  dio.options.headers["Authorization"] = "Bearer $token";
  return dio;
}