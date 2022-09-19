import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/models/login_model.dart';

part 'network_api.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST(Apis.login)
  Future<Login> loginRequest(@Body() body);

  // @POST(Apis.register)
  // Future<Register> registerRequest(@Body() body);
   
    
}
