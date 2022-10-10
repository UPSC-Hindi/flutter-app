
import 'package:dio/dio.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';

abstract class RemoteDataSource{
  Future<VideoModel> getVideo();
  Future<CoursesModel> getCourses(String filter,String type);
  Future<ResourcesModel> getResources(String filter);
  Future<CartModel>getCartDetails();
  Future<MyCoursesModel>getMyCourses();
  Future<void>addMyCart();
  Future<Response>addMyCourses(String batchId,bool isPaid);
}