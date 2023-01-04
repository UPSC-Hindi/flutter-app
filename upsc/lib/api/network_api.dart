import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/models/DeleteUserDetailsFromStream.dart';
import 'package:upsc/models/RemovefromCart.dart';
import 'package:upsc/models/StreamingUserDetails.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/models/joinstreaming.dart';
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
