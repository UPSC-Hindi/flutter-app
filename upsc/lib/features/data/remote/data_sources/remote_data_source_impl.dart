import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/batch_notes_model.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/myorders_model.dart';
import 'package:upsc/features/data/remote/models/payment_model.dart';
import 'package:upsc/features/data/remote/models/recorded_video_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/classschedule.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<VideoModel> getYouTubeVideo() async {
    try {
      var response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      return VideoModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
Future<ResourcesModel> getResources() async {
      try {
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getResources}',
          queryParameters: {'Category': 'Pathyakram'});

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
      print(error);
      rethrow;
    }
  }

  @override
  Future<CoursesModel> getCourses(String key, String value) async {
    try {
      final queryParameters = <String, dynamic>{key: value};
      var response = await dioAuthorizationData().get(
        '${Apis.baseUrl}${Apis.getCoursesFilter}?sizesView = true',
        // queryParameters: queryParameters,
      );
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
      return MyCoursesModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClassSchedulermodel> getMyClassSchedule() async {
    try {
      var response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.classScheduler}');
      return ClassSchedulermodel.fromJson(response.data);
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
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteCartCourse(String id) async {
    try {
      var response = await dioAuthorizationData()
          .delete('${Apis.baseUrl}${Apis.removefromCart}$id');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> savePaymentStatus(PaymentModel paymentData) async {
    try {
      Response response = await dioAuthorizationData().post(
        '${Apis.baseUrl}${Apis.savePaymentStatus}',
        data: paymentData.toJson(),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String> getOrderId(String batchId) async {
    try {
      return '12345';
    } catch (error) {
      flutterToast(error.toString());
      rethrow;
    }
  }

  @override
  getBatchNotes({required String batchId}) async {
    try {
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getBatchNotes}',
          queryParameters: {'batchId': batchId});
      BatchNotesModel data = BatchNotesModel.fromJson(response.data);
      if (data.status) {
        return data.data;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  getRecordedVideo({required String batchId}) async {
    try {
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getRecordedVideo}',
          queryParameters: {'batchId': batchId});
      RecordedVideoModel data = RecordedVideoModel.fromJson(response.data);
      if (data.status) {
        print(data);
        return data.data;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  getMyOrder() async{
    try{
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getMyOrders}');
      return MyOrdersModel.fromJson(response.data);
    }catch(error){
      rethrow;
    }
  }
}
