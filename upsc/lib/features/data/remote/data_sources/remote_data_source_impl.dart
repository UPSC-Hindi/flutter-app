import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<VideoModel> getVideo() async {
    try {
      var response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      print("--- Video Response ---");
      print(response);
      return VideoModel(status: false, data: null, msg: 'testing');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResourcesModel> getResources(String key, String value) async {
    try {
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getResources}',
          queryParameters: {key: value});
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
  Future<CoursesModel> getCourses(String key, String value) async {
    try {
      final queryParameters = <String, dynamic>{key: value};
      var response = await dioAuthorizationData().get(
        '${Apis.baseUrl}${Apis.getCoursesFilter}',
        queryParameters: {key: value},
      );
      print(response);
      return CoursesModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyCoursesModel> getMyCourses() async {
    try {
      var response =
          await dioAuthorizationData().get('${Apis.baseUrl}${Apis.mycourses}');
      print(response);
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

  @override
  Future<Response> addMyCourses(String batchId, bool isPaid) async {
    try {
      Response response = await dioAuthorizationData().post(
          '${Apis.baseUrl}${Apis.addToMyCourses}',
          data: {'batch_id': batchId, 'is_paid': isPaid});
      print(batchId);
      print(isPaid);
      print(response);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteCartCourse(String id) async {
    try {
      var response = await dioAuthorizationData()
          .delete('${Apis.baseUrl}${Apis.removefromCart}' + id);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
