import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/auth/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<void> updateLanguage(String language,String token) async {
    try {
      Response response = await dioAuthorizationData().put(
        Apis.baseUrl + Apis.putUserLanguage,
        data: {'language': language},
      );
      print('---Successful Put Language Request ---');
      // print(response);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> updateStream(String stream,String token) async {
    try {
      Response response = await dioAuthorizationData().put(
        Apis.baseUrl + Apis.putUserLanguage,
        data: {'Stream': stream},
      );
      print('---Successful Put Stream Request ---');
      // print(response);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<Response> logout() async{
    try{
      Response response = await dioAuthorizationData().post('${Apis.baseUrl}${Apis.logout}');
      return response;
    }catch(error){
      rethrow;
    }
  }
}
