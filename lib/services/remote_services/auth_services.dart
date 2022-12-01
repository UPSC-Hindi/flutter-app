import 'dart:convert';

import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
import 'package:upsc_web/utils.dart';

class AuthServices {
  Future<void> loginServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.login, data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> registerServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.register, data: data);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> resendOtpService(dynamic token) async {
    try {
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.resendMobileVerificationOtp,
      token: token);
      print(response);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> verifyPhoneNumberService(dynamic data,String token) async {
    try {
      dynamic response = await BaseClient.post(
          url: Api.baseUrl + Api.verifyMobileNumber, data: data,token: token);
      print(response);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
