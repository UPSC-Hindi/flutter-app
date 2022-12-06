import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/auth/auth_data_source.dart';
import 'package:upsc/features/data/remote/models/stream_model.dart';

class AuthDataSourceImpl implements AuthDataSource {
  //Todo pls check what is the use of this in detail
  @override
  Future<void> updateLanguage(String language, String token) async {
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

//Todo pls check what is the use of this in detail
  @override
  Future<void> updateStream(List<String> stream) async {
    try {
      Response response = await dioAuthorizationData().put(
        Apis.baseUrl + Apis.putUserStream,
        data: {'Stream': stream},
      );
      print(response);
      print('---Successful Put Stream Request ---');
      // print(response);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<Response> logout() async {
    try {
      Response response =
          await dioAuthorizationData().post('${Apis.baseUrl}${Apis.logout}');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> updateUserDetails(
      String fullName, String userAddress) async {
    try {
      Response response = await dioAuthorizationData().put(
        '${Apis.baseUrl}${Apis.updateUserDetails}',
        data: {
          "FullName": fullName,
          "Useraddress": userAddress,
        },
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> updateUserProfilePhoto(XFile file) async {
    try {
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      });
      Response response = await dioAuthorizationData()
          .put("${Apis.baseUrl}${Apis.updateUserProfilePhoto}", data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getStream() async {
    try {
      List<String> stream = [];
      Response response = await dioAuthorizationData()
          .get(Apis.baseUrl + Apis.getCategoryStream);
      StreamModel jsonResponse = StreamModel.fromJson(response.data);

      for (StreamDataModel data in jsonResponse.data) {
        stream.add(data.title);
      }
      return stream;
    } catch (error) {
      rethrow;
    }
  }
}
