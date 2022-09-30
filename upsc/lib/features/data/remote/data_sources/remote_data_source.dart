
import 'package:upsc/features/data/remote/models/video_model.dart';

abstract class RemoteDataSource{
  Future<VideoModel> getVideo();
  Future<VideoModel> getCourses();
}