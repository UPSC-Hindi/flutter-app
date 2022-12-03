import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/features/controller/auth_controller.dart';
import 'package:upsc_web/features/model/auth/register_model.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthController authController = AuthController();

  Future<void>registerUser(dynamic data)async{
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
    emit(LoadingAuth());
    try{
      if(await authController.login(data)){
        emit(LoginSuccess());
      }else{
        emit(ErrorAuth());
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
}
