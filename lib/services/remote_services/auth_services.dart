import 'package:dio/dio.dart';
import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';

class AuthServices {
  Future<dynamic> loginServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.login, data: data);
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> registerServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.register, data: data);
      return response.data;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> resendOtpService() async {
    try {
      String? authToken = PreferencesHelper.getString(Preferences.authToken);
      dynamic response = await BaseClient.get(
          url: Api.baseUrl + Api.resendMobileVerificationOtp, token: authToken);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> verifyPhoneNumberService(dynamic data) async {
    try {
      String? authToken = PreferencesHelper.getString(Preferences.authToken);
      dynamic response = await BaseClient.post(
          url: Api.baseUrl + Api.verifyMobileNumber,
          data: data,
          token: authToken);
      return response.data;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> googleAuthService(dynamic data) async {
    try {
      var response = await BaseClient.post(
        url: Api.baseUrl + Api.googleAuth,
        data: data,
      );
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> updateLanguage(String language) async {
    try {
      var response = await BaseClient.put(
        url: Api.baseUrl + Api.updateUserLanguage,
        data: {'language': language},
      );
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> updateStream(List<String> stream) async {
    try {
      var response = await BaseClient.put(
        url: Api.baseUrl + Api.updateUserStream,
        data: {'Stream': stream},
      );
      return response;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> logoutService() async {
    try {
      dynamic response = await BaseClient.post(url: Api.baseUrl + Api.logout);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> updateUserDetailsService(
      String fullName, String userAddress) async {
    try {
      dynamic response = await BaseClient.put(
        url: Api.baseUrl + Api.updateUserProfileInfo,
        data: {
          "FullName": fullName,
          "Useraddress": userAddress,
        },
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> updateUserProfilePhotoService(
      var fileBytes, String imageName) async {
    try {
      FormData data = FormData.fromMap({
        "file": MultipartFile.fromBytes(fileBytes, filename: imageName),
      });
      dynamic response = await BaseClient.put(
          url: "${Api.baseUrl}${Api.updateUserProfilePhoto}", data: data);
      print(response);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> requestToLogoutService(dynamic data) async {
    try {
      dynamic response = await BaseClient.post(
        url: Api.baseUrl + Api.requestToLogout,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
