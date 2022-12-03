import 'package:upsc_web/features/model/auth/register_model.dart';
import 'package:upsc_web/features/model/auth/stream_model.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils/utils.dart';

class AuthController {
  AuthServices authServices = AuthServices();

  Future<bool> login(dynamic data) async {
    await authServices.loginServices(data).then((value) async {
      // write your code
    }).onError((error, stackTrace) {
      throw error!;
    });
    return true;
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
        Utils.toastMessage(response.data['mobileNumberVerificationOTP'].toString());
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
      dynamic responseJson =
          await authServices.verifyPhoneNumberService(data);
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

  Future<List<String>> getStream() async {
    try {
      List<String> stream = [];
      dynamic response = await authServices.getStreamService();
      StreamModel jsonResponse = StreamModel.fromJson(response.data);
      for (StreamDataModel data in jsonResponse.data) {
        stream.add(data.title);
      }
      return stream;
    } catch (error) {
      rethrow;
    }
  }
}
