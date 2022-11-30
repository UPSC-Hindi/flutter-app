import 'package:device_info_plus/device_info_plus.dart';
import 'package:upsc_web/features/model/auth/register_model.dart';
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

  Future<bool>register(dynamic data)async{
    try{
      dynamic response = await authServices.registerServices(data);
      RegisterModel user = RegisterModel.fromJson(response);
      if(user.status){
        //TODO: add preferences code here

        Util.toastMessage(user.msg);
        return true;
      }else{
        Util.toastMessage(user.msg);
        return user.status;
      }
    }catch(error){
      Util.toastMessage(error.toString());
      rethrow;
    }
  }
}