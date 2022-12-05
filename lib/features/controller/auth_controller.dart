import 'package:upsc_web/features/model/auth/login_model.dart';
import 'package:upsc_web/features/model/auth/register_model.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:upsc_web/utils/utils.dart';

class AuthController {
  AuthServices authServices = AuthServices();

  Future<LoginModel> login(dynamic data) async {
    try {
      var response = await authServices.loginServices(data);
      var user = LoginModel.fromJson(response);
      if(user.data.mobileVerified){
        await PreferencesHelper.setString(
            Preferences.accessToken, user.data.accessToken);
        await PreferencesHelper.setBoolean(
            Preferences.isLoggedIn, true);
        await PreferencesHelper.setString(
            Preferences.name, user.data.fullName);
        await PreferencesHelper.setString(
            Preferences.email, user.data.email);
        await PreferencesHelper.setString(
            Preferences.phoneNUmber, user.data.phoneNumber);
        await PreferencesHelper.setString(Preferences.language,
            user.data.language);
        Languages.isEnglish = user.data.language == "hi" ? false : true;
        await PreferencesHelper.setString(
            Preferences.profileImage, user.data.profilePhoto);
        await PreferencesHelper.setString(
            Preferences.address, user.data.address);
      }
      Utils.flutterToast(user.msg);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<RegisterModel> register(dynamic data) async {
    try {
      dynamic response = await authServices.registerServices(data);
      RegisterModel user = RegisterModel.fromJson(response);

      await PreferencesHelper.setString(Preferences.email, user.data.email);
      await PreferencesHelper.setString(Preferences.authToken, user.data.token);

      Utils.flutterToast(user.msg);

      Utils.toastMessage(user.data.mobileNumberVerificationOtp.toString());

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
      await PreferencesHelper.setBoolean(Preferences.isLoggedIn, true);
      PreferencesHelper.setString(
          Preferences.accessToken, response.data['access_token']);
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
