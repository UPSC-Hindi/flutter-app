import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:upsc_web/features/model/auth/google_auth_model.dart';
import 'package:upsc_web/features/model/auth/login_model.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:upsc_web/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;

class AuthController {
  AuthServices authServices = AuthServices();

  Future<BaseModel> login(dynamic data) async {
    try {
      var response = await authServices.loginServices(data);
      BaseModel baseResponse = BaseModel.fromJson(response);
      if (baseResponse.status) {
        LoginModel user = LoginModel.fromJson(response);
        await PreferencesHelper.setString(
            Preferences.accessToken, user.data.accessToken);
        if (user.data.mobileVerified) {
          await PreferencesHelper.setBoolean(Preferences.isLoggedIn, true);
          await PreferencesHelper.setString(
              Preferences.name, user.data.fullName);
          await PreferencesHelper.setString(Preferences.email, user.data.email);
          await PreferencesHelper.setString(
              Preferences.phoneNUmber, user.data.phoneNumber);
          await PreferencesHelper.setString(
              Preferences.language, user.data.language);
          Languages.isEnglish = user.data.language == "hi" ? false : true;
          await PreferencesHelper.setString(
              Preferences.profileImage, user.data.profilePhoto);
          await PreferencesHelper.setString(
              Preferences.address, user.data.address);
        }
        Utils.flutterToast(user.msg);
      } else {
        Utils.toastMessage(baseResponse.msg);
      }
      return baseResponse;
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<BaseModel> register(dynamic data) async {
    try {
      dynamic response = await authServices.registerServices(data);
      BaseModel user = BaseModel.fromJson(response);
      if (user.status) {
        await PreferencesHelper.setString(
            Preferences.email, user.data['email']);
        await PreferencesHelper.setString(
            Preferences.authToken, user.data['token']);
        Utils.toastMessage(user.data['mobileNumberVerificationOTP'].toString());
      }
      Utils.flutterToast(user.msg);
      return user;
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool> resendOtp() async {
    try {
      dynamic responseJson = await authServices.resendOtpService();
      BaseModel response = BaseModel.fromJson(responseJson);
      if (response.status) {
        Utils.toastMessage(
            response.data['mobileNumberVerificationOTP'].toString());
      }
      Utils.flutterToast(response.msg);
      return response.status;
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool> verifyPhoneNumber(dynamic data) async {
    try {
      dynamic responseJson = await authServices.verifyPhoneNumberService(data);
      BaseModel response = BaseModel.fromJson(responseJson);
      if (response.status) {
        await PreferencesHelper.setBoolean(Preferences.isLoggedIn, true);
        PreferencesHelper.setString(
            Preferences.accessToken, response.data['access_token']);
      }
      Utils.flutterToast(response.msg);
      return response.status;
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<List<bool>> googleAuth() async {
    try {
      googleauth.GoogleSignInAccount? result;
      final _googleSignIn = googleauth.GoogleSignIn();
      result = await _googleSignIn.signIn();
      if (result!.email.isNotEmpty) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        dynamic data = {
          'deviceConfig': webBrowserInfo.userAgent,
          'DeviceName': webBrowserInfo.appName,
          'email': result.email,
          'profilePhoto': result.photoUrl,
          'usernameFromGoogle': result.displayName,
        };
        dynamic response = await authServices.googleAuthService(data);
        GoogleAuthModel user = GoogleAuthModel.fromJson(response.data);
        Util.flutterToast(user.msg);
        if (user.status) {
          print(user.data.accessToken);
          PreferencesHelper.setString(
              Preferences.accessToken, user.data.accessToken);
          PreferencesHelper.setString(Preferences.name, user.data.fullName);
          PreferencesHelper.setString(Preferences.email, user.data.email);
          PreferencesHelper.setString(
              Preferences.profileImage, user.data.profilePhoto);
          PreferencesHelper.setString(Preferences.address, user.data.address);
          return [user.status, user.data.userMobileNumberVerified];
        }
        return [user.status, false];
        //await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
      return [false, false];
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      return [false, false];
    }
  }

  Future<bool> updateStreamLanguage({dynamic language, dynamic stream}) async {
    try {
      dynamic responseLanguageJson =
          await authServices.updateLanguage(language);
      BaseModel responseLanguage = BaseModel.fromJson(responseLanguageJson);

      dynamic responseStreamJson = await authServices.updateStream(stream);
      BaseModel responseStream = BaseModel.fromJson(responseStreamJson);

      Utils.flutterToast("${responseStream.msg} ${responseLanguage.msg}");
      return responseStream.status && responseLanguage.status;
    } catch (error) {
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool> logout(BuildContext context) async {
    Utils.showLoading(context);
    try {
      dynamic responseJson = await authServices.logoutService();
      BaseModel response = BaseModel.fromJson(responseJson.data);
      Utils.flutterToast(response.msg);
      Utils.hideLoading(context);
      return response.status;
    } catch (error) {
      Utils.hideLoading(context);
      Utils.toastMessage(error.toString());
      return false;
    }
  }

  Future<bool> updateUserDetails(String fullName, String userAddress) async {
    try {
      dynamic response =
          await authServices.updateUserDetailsService(fullName, userAddress);
      BaseModel data = BaseModel.fromJson(response);
      if (data.status) {
        PreferencesHelper.setString(Preferences.address, userAddress);
        PreferencesHelper.setString(Preferences.name, fullName);
      }
      Util.flutterToast(data.msg);
      return data.status;
    } catch (error) {
      Util.toastMessage(error.toString());
      return false;
    }
  }

  Future<bool> updateUserProfilePhoto(var fileBytes, String imageName) async {
    try {
      dynamic response = await authServices.updateUserProfilePhotoService(
          fileBytes, imageName);
      BaseModel data = BaseModel.fromJson(response);
      PreferencesHelper.setString(
          Preferences.profileImage, data.data['fileUploadedLocation']);
      Util.flutterToast(data.msg);
      return data.status;
    } catch (error) {
      Util.toastMessage(error.toString());
      return false;
    }
  }

  Future<bool> requestToLogout(String userEmail) async {
    try {
      dynamic response = await authServices.requestToLogoutService(
        {
          'email_phoneNumber': userEmail,
        },
      );
      BaseModel data = BaseModel.fromJson(response.data);
      Util.flutterToast(data.msg);
      return data.status;
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      return false;
    }
  }

  Future<BaseModel> resetPasswordVerification(dynamic email_phoneNumber) async {
    try {
      dynamic response = await authServices.resetPasswordVerificationService({
        'email_phoneNumber': email_phoneNumber,
      });
      print(response);
      return BaseModel.fromJson(response);
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<BaseModel> resetPasswordVerifyOtp(
      String email_phoneNumber, String otp) async {
    try {
      dynamic response = await authServices.resetPasswordVerifyOtpService({
        'email_phoneNumber': email_phoneNumber,
        'otp': otp,
      });
      print(response);
      return BaseModel.fromJson(response);
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<BaseModel> resendPasswordVerifyOtp(String email_phoneNumber) async {
    try {
      dynamic response = await authServices.resendPasswordVerifyOtpService({
        'email_phoneNumber': email_phoneNumber,
      });
      print(response);
      return BaseModel.fromJson(response.data);
    } catch (error) {
      print(error);
      Utils.toastMessage(error.toString());
      rethrow;
    }
  }
}
