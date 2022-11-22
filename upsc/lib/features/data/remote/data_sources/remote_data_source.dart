
import 'package:dio/dio.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/data/remote/models/batch_notes_model.dart';
import 'package:upsc/features/data/remote/models/cart_model.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/payment_model.dart';
import 'package:upsc/features/data/remote/models/recorded_video_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/models/classschedule.dart';

abstract class RemoteDataSource{
  Future<VideoModel> getYouTubeVideo();
  Future<CoursesModel> getCourses(String filter,String type);
  Future<ClassSchedulermodel> getMyClassSchedule();
  Future<CartModel>getCartDetails();
  Future<MyCoursesModel>getMyCourses();
  Future<void>addMyCart();
  Future<Response>addMyCourses(String batchId,bool isPaid);
  Future<Response>deleteCartCourse(String id);
  Future<Response>savePaymentStatus(PaymentModel paymentData);
  Future<String>getOrderId(String batchId);
  Future<List<RecordedVideoDataModel>>getRecordedVideo({required String batchId});
  Future<List<BatchNotesDataModel>>getBatchNotes({required String batchId});
}