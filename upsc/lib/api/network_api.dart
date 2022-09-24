import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/models/VerifyMobileNumber.dart';
import 'package:upsc/models/VerifyMobileNumber.dart';
import 'package:upsc/models/forgotpassword.dart';
import 'package:upsc/models/login_model.dart';
import 'package:upsc/models/passwordotpresend.dart';
import 'package:upsc/models/passwordverifyotp.dart';
import 'package:upsc/models/register.dart';
import 'package:upsc/models/resendotp.dart';
import 'package:upsc/models/resetpassword.dart';
import 'package:upsc/screens/passwordVerified.dart';

part 'network_api.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST(Apis.login)
  Future<Login> loginRequest(@Body() body);

  @POST(Apis.register)
  Future<Register> registerRequest(@Body() body);

  @POST(Apis.verifymobilenumber)
  Future<VerifyMobileNumber> verifymobilenumberRequest(@Body() body);

  @GET(Apis.resendotpm)
  Future<Resendotp> resendotpRequest();

  @POST(Apis.forgetpassword)
  Future<ForgetPassword> forgetpasswordRequest(@Body() body);

  @POST(Apis.passwordverifyotp)
  Future<PasswordVerifyOtp> passwordverifyotpRequest(@Body() body);

  @POST(Apis.passwordotpresend)
  Future<PasswordOtpResend> passwordotpresendRequest(@Body() body);

  @POST(Apis.resetpassword)
  Future<ResetPassword> resetpasswordRequest(@Body() body);
}
