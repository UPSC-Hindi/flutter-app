import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthDataSource{
  Future<Response> logout();
  Future<Response> updateUserProfilePhoto(XFile file);
  Future<Response> updateUserDetails(String fullName,String userAddress);
  Future<List<String>> getStream();
}