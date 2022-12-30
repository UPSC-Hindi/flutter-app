part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoadingAuth extends AuthState {}
class ErrorAuth extends AuthState{}

class RegisterSuccess extends AuthState{}
class LoginSuccess extends AuthState{}
class VerificationOtpSuccess extends AuthState{}
class ResendOtpSuccess extends AuthState{}
class UpdateLanguageStreamSuccess extends AuthState{}
class UnVerifiedNumber extends AuthState{
  final String phoneNumber;
  UnVerifiedNumber({required this.phoneNumber});
}
class RequestToLogout extends AuthState {}
class GoogleSuccess extends AuthState{}
class GooglePhoneNumberVerification extends AuthState{}
class RequestLogoutSuccess extends AuthState {}