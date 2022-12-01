import 'package:upsc_web/features/model/auth/register_model.dart';
import 'package:upsc_web/features/model/base_model.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';
import 'package:upsc_web/utils.dart';

class AuthController{
  AuthServices authServices = AuthServices();

  Future<bool>login(dynamic data)async{
    await authServices.loginServices(data).then((value) async{
      // write your code
    }).onError((error, stackTrace) {
      throw error!;
    });
    return true;
  }

  Future<RegisterModel>register(dynamic data)async{
    try{
      dynamic response = await authServices.registerServices(data);
      RegisterModel user = RegisterModel.fromJson(response);
        Util.flutterToast(user.msg);
        Util.toastMessage(user.data.mobileNumberVerificationOtp.toString());
        return user;
    }catch(error){
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool>resendOtp(dynamic token)async{
    try{
      dynamic responseJson = await authServices.resendOtpService(token);
      BaseModel response = BaseModel.fromJson(responseJson);
      if(response.status){
        //TODO dinesh show here otp;
      }
      Util.flutterToast(response.msg);
      return response.status;
    }catch(error){
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<bool>verifyPhoneNumber(dynamic data,String token)async{
    try{
      dynamic responseJson = await authServices.verifyPhoneNumberService(data,token);
      BaseModel response = BaseModel.fromJson(responseJson);
      Util.flutterToast(response.msg);
      return response.status;
    }catch(error){
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

}