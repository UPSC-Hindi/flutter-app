import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upsc_web/features/controller/auth_controller.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthController authController = AuthController();

  Future<void>registerUser(dynamic data)async{
    emit(LoadingAuth());
    try{
      if(await authController.register(data)){
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
}
