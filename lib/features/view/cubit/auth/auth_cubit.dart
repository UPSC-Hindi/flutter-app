import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/features/controller/auth_controller.dart';
import 'package:upsc_web/features/model/auth/login_model.dart';
import 'package:upsc_web/features/model/auth/register_model.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthController authController = AuthController();

  Future<void>registerUser(Map<String,dynamic> data)async{
    emit(LoadingAuth());
    try{
      RegisterModel user = await authController.register(data);
      if(user.status){
        emit(RegisterSuccess());
      }else{
        emit(ErrorAuth());
      }
    }catch(error){
      emit(ErrorAuth());
    }
  }

  Future<void>loginUser(dynamic data)async{
    try{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      data["deviceConfig"] = webBrowserInfo.userAgent;
      data["deviceName"] = webBrowserInfo.appName;
      LoginModel user = await authController.login(data);
      if(user.data.mobileVerified){
        emit(LoginSuccess());
      }else{
        emit(UnVerifiedNumber(phoneNumber: user.data.phoneNumber));
      }
    }catch(error){
      emit(ErrorAuth());
    }
  }

  Future<void>verifyOtp(String otp)async{
    emit(LoadingAuth());
    try{
      if(await authController.verifyPhoneNumber({'otp' : otp})){
        emit(VerificationOtpSuccess());
      }else{
        emit(ErrorAuth());
      }
    }catch(error){
      emit(ErrorAuth());
    }
  }

  Future<void>resendOtp()async{
    emit(LoadingAuth());
    try{
      if(await authController.resendOtp()){
        emit(ResendOtpSuccess());
      }else{
        emit(ErrorAuth());
      }
    }catch(error){
      emit(ErrorAuth());
    }
  }

  Future<void>updateStreamLanguage(
      {required String language, required List<String> stream})async{
    emit(LoadingAuth());
    try{
      if(await authController.updateStreamLanguage(language: language,stream: stream)){
        PreferencesHelper.setString(Preferences.language,
            language);
        PreferencesHelper.setStringList(
            Preferences.course, stream);
        PreferencesHelper.setBoolean(Preferences.isLoggedIn, true);
        emit(UpdateLanguageStreamSuccess());
      }else{
        emit(ErrorAuth());
      }
    }catch(error){
      emit(ErrorAuth());
    }
  }
}
