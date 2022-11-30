import 'dart:convert';

import 'package:upsc_web/services/base_api/api.dart';
import 'package:upsc_web/services/base_api/base_client.dart';

class AuthServices{

  Future<void>loginServices(dynamic data)async{
    try{
      dynamic response =  await BaseClient.post(url: Api.baseUrl+Api.login,data: data);
      return response;
    }catch(error){
      rethrow;
    }
  }

  Future<dynamic> registerServices(dynamic data)async{
    try{
      dynamic response =  await BaseClient.post(url: Api.baseUrl+Api.register,data: data);
      print(response);
      return response;
    }catch(error){
      print('hello saurabh');
      print(error);
      rethrow;
    }
  }
}