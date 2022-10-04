import 'package:upsc/features/data/remote/models/resources_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';

abstract class RemoteDataSource{
  Future<VideoModel> getVideo();
  Future<VideoModel> getCourses();
  Future<ResourcesModel> getResources(String filter);
}