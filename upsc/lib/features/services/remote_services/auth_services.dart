
import 'package:upsc/api/api.dart';
import 'package:upsc/api/base_client.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class AuthServices {
  Future<dynamic> loginServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Apis.baseUrl + Apis.login, data: data);
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> registerServices(dynamic data) async {
    try {
      dynamic response =
          await BaseClient.post(url: Apis.baseUrl + Apis.register, data: data);
      return response.data;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> resendOtpService() async {
    try {
      String? authToken = SharedPreferenceHelper.getString(Preferences.auth_token);
      dynamic response = await BaseClient.get(
          url: Apis.baseUrl + Apis.resendMobileVerificationOtp, token: authToken);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> verifyPhoneNumberService(dynamic data) async {
    try {
      String? authToken = SharedPreferenceHelper.getString(Preferences.auth_token);
      dynamic response = await BaseClient.post(
          url: Apis.baseUrl + Apis.verifyMobileNumber,
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
        url: Apis.baseUrl + Apis.googleAuth,
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
        url: Apis.baseUrl + Apis.updateUserLanguage,
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
        url: Apis.baseUrl + Apis.updateUserStream,
        data: {'Stream': stream},
      );
      return response;
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> logoutService() async {
    try {
      dynamic response = await BaseClient.post(url: Apis.baseUrl + Apis.logout);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // Future<dynamic> updateUserDetailsService(
  //     String fullName, String userAddress) async {
  //   try {
  //     dynamic response = await BaseClient.put(
  //       url: Apis.baseUrl + Apis.updateUserProfileInfo,
  //       data: {
  //         "FullName": fullName,
  //         "Useraddress": userAddress,
  //       },
  //     );
  //     return response;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<dynamic> updateUserProfilePhotoService(
  //     var fileBytes, String imageName) async {
  //   try {
  //     FormData data = FormData.fromMap({
  //       "file": MultipartFile.fromBytes(fileBytes, filename: imageName),
  //     });
  //     dynamic response = await BaseClient.put(
  //         url: "${Api.baseUrl}${Api.updateUserProfilePhoto}", data: data);
  //     print(response);
  //     return response;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<dynamic> requestToLogoutService(dynamic data) async {
    try {
      dynamic response = await BaseClient.post(
        url: Apis.baseUrl + Apis.requestToLogout,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resetPasswordVerificationService(dynamic data)async{
    try {
      dynamic response = await BaseClient.post(
        url: Apis.baseUrl + Apis.resetPassword,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> resetPasswordVerifyOtpService(dynamic data)async{
    try {
      dynamic response = await BaseClient.post(
        url: Apis.baseUrl + Apis.resetPasswordVerifyOtp,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> resendPasswordVerifyOtpService(dynamic data)async{
    try {
      dynamic response = await BaseClient.post(
        url: Apis.baseUrl + Apis.resendOtp,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getBannerApi() async {
    try {
      dynamic response = await BaseClient.get(
        url: Apis.baseUrl + Apis.banner,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getStreamService() async {
    try {
      dynamic response =
          await BaseClient.get(url: Apis.baseUrl + Apis.getCategoryStream);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
