import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/models/auth/VerifyMobileNumber.dart';
import 'package:upsc/models/auth/forgotpassword.dart';
import 'package:upsc/models/auth/login_model.dart';
import 'package:upsc/models/auth/passwordotpresend.dart';
import 'package:upsc/models/auth/passwordverifyotp.dart';
import 'package:upsc/models/auth/register.dart';
import 'package:upsc/models/auth/resendotp.dart';
import 'package:upsc/models/auth/resetpassword.dart';


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
  
  @POST(Apis.joinmeeting)
  Future<JoinStreaming> joinmeetingRequest(@Body() body);
  
  @POST(Apis.joinmeeting)
  Future<AddToCart> addtocartRequest(@Body() body);
}
