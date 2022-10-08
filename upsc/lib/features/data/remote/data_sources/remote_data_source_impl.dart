import 'package:dio/src/response.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/models/course_model.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<VideoModel> getVideo() async {
    try {
      var response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      print("--- Video Response ---");
      print(response);
      return VideoModel(status: false, data: null, msg: 'testing');
      // return VideoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResourcesModel> getResources(String filter) async {
    try {
      var filterUrl = filter.isNotEmpty ? filter : '';

      Response response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getResources}$filterUrl');

      return ResourcesModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartModel> getCartDetails() async {
    try {
      Response response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getcartdata}');
      CartModel data = CartModel.fromJson(response.data);
      return data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<CourseModel> getCourses(String filter, String type) async {
    try {
      final queryParameters = <String, dynamic>{type: filter};
      print('${Apis.baseUrl}${Apis.getCoursesFilter}?$type=$filter');

      var response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getCoursesFilter}');

      // Response response = await dioAuthorizationData().get('${Apis.baseUrl}${Apis.getCoursesFilter}',queryParameters: queryParameters);

      print(response);
      return CourseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyCoursesModel> getMyCourses() async {
    try {
      var response =
          await dioAuthorizationData().get('${Apis.baseUrl}${Apis.mycourses}');
      return MyCoursesModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  //TODO by dinesh
  @override
  Future<void> addMyCart() {
    // TODO: implement addMyCart
    throw UnimplementedError();
  }
}
