import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';

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
      print("input data");
      print(data);
      dynamic response =
          await BaseClient.post(url: Api.baseUrl + Api.register, data: data);
      print("output data");
      print(response);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> resendOtpService() async {
    try {
      String? authToken = PreferencesHelper.getString(Preferences.authToken);
      dynamic response = await BaseClient.get(
        url: Api.baseUrl + Api.resendMobileVerificationOtp,
      token: authToken);
      print(response);
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
          url: Api.baseUrl + Api.verifyMobileNumber, data: data,token: authToken);
      print(response);
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> getStreamService() async{
    try{
      dynamic response = await BaseClient.get(url : Api.baseUrl+Api.getCategoryStream);
      return response;
    }catch(error){
      rethrow;
    }
  }
}
