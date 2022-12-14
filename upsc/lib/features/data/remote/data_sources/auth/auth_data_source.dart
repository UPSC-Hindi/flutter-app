import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthDataSource{
  Future<void> updateStream(List<String> stream);
  Future<void> updateLanguage(String language,String token);
  Future<Response> logout();
  Future<Response> updateUserProfilePhoto(XFile file);
  Future<Response> updateUserDetails(String fullName,String userAddress);
  Future<List<String>> getStream();
}