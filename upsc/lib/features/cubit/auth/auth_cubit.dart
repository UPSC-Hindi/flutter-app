import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:upsc/features/controller/auth_controller.dart';
import 'package:upsc/features/data/remote/models/base_model.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthController authController = AuthController();

  Future<void> registerUser(Map<String, dynamic> data) async {
    emit(LoadingAuth());
    try {
      BaseModel user = await authController.register(data);
      if (user.status) {
        emit(RegisterSuccess());
      } else {
        emit(ErrorAuth());
      }
    } catch (error) {
      emit(ErrorAuth());
    }
  }

  Future<void> loginUser(dynamic data) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      data["deviceConfig"] = webBrowserInfo.userAgent;
      data["deviceName"] = webBrowserInfo.appName;
      BaseModel user = await authController.login(data);

      if(user.status){
        if (user.data['mobileVerified']) {
          emit(LoginSuccess());
        }else {
          emit(UnVerifiedNumber(phoneNumber: user.data['phoneNumber']));
        }
      }else{
        emit(RequestToLogout());
      }
    } catch (error) {
      emit(ErrorAuth());
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(LoadingAuth());
    try {
      if (await authController.verifyPhoneNumber({'otp': otp})) {
        emit(VerificationOtpSuccess());
      } else {
        emit(ErrorAuth());
      }
    } catch (error) {
      emit(ErrorAuth());
    }
  }

  Future<void> resendOtp() async {
    emit(LoadingAuth());
    try {
      if (await authController.resendOtp()) {
        emit(ResendOtpSuccess());
      } else {
        emit(ErrorAuth());
      }
    } catch (error) {
      emit(ErrorAuth());
    }
  }

  Future<void> updateStreamLanguage(
      {required String language, required List<String> stream}) async {
    emit(LoadingAuth());
    try {
      if (await authController.updateStreamLanguage(
          language: language, stream: stream)) {
        SharedPreferenceHelper.setString(Preferences.language, language);
        SharedPreferenceHelper.setStringList(Preferences.course, stream);
        SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
        Languages.initState();
        emit(UpdateLanguageStreamSuccess());
      } else {
        emit(ErrorAuth());
      }
    } catch (error) {
      emit(ErrorAuth());
    }
  }

  Future<void> googleAuth()async{
    emit(LoadingAuth());
     List<bool>response = await authController.googleAuth();
     if(response.first){
       if(response.last){
         emit(GoogleSuccess());
       }else{
         emit(GooglePhoneNumberVerification());
       }
     }else{
       emit(ErrorAuth());
     }
  }

  Future<void>requestLogout(String userEmail)async{
    emit(LoadingAuth());
    if(await authController.requestToLogout(userEmail)){
      emit(RequestLogoutSuccess());
    }else{
      emit(ErrorAuth());
    }
  }
}
