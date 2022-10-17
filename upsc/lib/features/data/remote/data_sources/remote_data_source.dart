
import 'package:dio/dio.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';

abstract class RemoteDataSource{
  Future<VideoModel> getYouTubeVideo();
  Future<CoursesModel> getCourses(String filter,String type);
  Future<ResourcesModel> getResources(String key,String value);
  Future<CartModel>getCartDetails();
  Future<MyCoursesModel>getMyCourses();
  Future<void>addMyCart();
  Future<Response>addMyCourses(String batchId,bool isPaid);
  Future<Response>deleteCartCourse(String id);
}