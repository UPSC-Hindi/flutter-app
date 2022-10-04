import 'package:dio/src/response.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import '../models/resources_model.dart';


class RemoteDataSourceImpl extends RemoteDataSource{
  @override
  Future<VideoModel> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }

  @override
  Future<VideoModel> getVideo() async{
    try {
      var response = await dioAuthorizationData().get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      print("--- Video Response ---");
      print(response);
      return VideoModel(status: false,data: null, msg: 'testing');
      // return VideoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<ResourcesModel> getResources(String filter) async{
    try{
      var filterUrl = filter.isNotEmpty?filter:'';

      Response response = await dioAuthorizationData(
      ).get('${Apis.baseUrl}${Apis.getResources}$filterUrl');

      return ResourcesModel.fromJson(response.data);
    }catch(e){
      rethrow;
    }
  }

}