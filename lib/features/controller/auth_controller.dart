import 'package:upsc_web/features/model/auth/login_model.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:upsc_web/utils/utils.dart';

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
      print(responseJson);
      BaseModel response = BaseModel.fromJson(responseJson);
      print("Successfully verify otp done from base model");
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
}
