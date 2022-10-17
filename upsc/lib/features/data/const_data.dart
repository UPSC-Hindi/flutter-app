

import 'package:dio/dio.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

Dio dioAuthorizationData() {
  var token = SharedPreferenceHelper.getString(Preferences.access_token);
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
