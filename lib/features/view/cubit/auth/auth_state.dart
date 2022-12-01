part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoadingAuth extends AuthState {}
class ErrorAuth extends AuthState{}

class RegisterSuccess extends AuthState{
  final RegisterDataModel user;

  RegisterSuccess({required this.user});
}
class LoginSuccess extends AuthState{}
class VerificationOtpSuccess extends AuthState{}
class ResendOtpSuccess extends AuthState{}
