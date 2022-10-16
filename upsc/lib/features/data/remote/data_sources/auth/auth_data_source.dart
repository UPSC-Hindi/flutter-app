import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthDataSource{
  Future<void> updateStream(String stream,String token);
  Future<void> updateLanguage(String language,String token);
  Future<Response> logout();
  Future<Response> updateUserProfilePhoto(XFile file);
  Future<Response> updateUserDetails(String fullName,String userAddress);
}