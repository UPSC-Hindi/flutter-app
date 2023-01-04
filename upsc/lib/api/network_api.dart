import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/models/DeleteUserDetailsFromStream.dart';
import 'package:upsc/models/GoogleSignIn.dart';
import 'package:upsc/models/RemovefromCart.dart';
import 'package:upsc/models/StreamingUserDetails.dart';
import 'package:upsc/models/auth/Logout.dart';
import 'package:upsc/models/auth/postUserMobileNumber.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/models/auth/VerifyMobileNumber.dart';
import 'package:upsc/models/auth/forgotpassword.dart';
import 'package:upsc/models/auth/login_model.dart';
import 'package:upsc/models/auth/passwordotpresend.dart';
import 'package:upsc/models/auth/passwordverifyotp.dart';
import 'package:upsc/models/auth/register.dart';
import 'package:upsc/models/auth/resendotp.dart';
import 'package:upsc/models/auth/resetpassword.dart';
import 'package:upsc/models/notificationget.dart';
import 'package:upsc/models/orderIdgeneration.dart';

part 'network_api.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(Apis.banner)
  Future<getbannerdetails> bannerimagesRequest();

  @POST(Apis.joinmeeting)
  Future<JoinStreaming> joinmeetingRequest(@Body() body);

  @GET(Apis.streamingUserDetails)
  Future<StreamingUserDetails> streaminguserdetailsRequest();

  @DELETE(Apis.deleteUserDetailsFromStream)
  Future<DeleteUserDetailsFromStream> deleteuserdetailsfromstreamRequest(
      @Body() body);

  @POST(Apis.joinmeeting)
  Future<AddToCart> addtocartRequest(@Body() body);

  @POST(Apis.joinmeeting)
  Future<OrderIdGeneration> getorderidRequest(@Body() body);

  @DELETE(Apis.removefromCart)
  Future<RemovefromCart> removefromcartRequest(@Body() body);

  @GET(Apis.getnotification)
  Future<NotificationGet> getnotificationRequest();
}
