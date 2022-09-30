import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';


class RemoteDataSourceImpl extends RemoteDataSource{
  var token = SharedPreferenceHelper.getString(Preferences.access_token);
  @override
  Future<VideoModel> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }

  @override
  Future<VideoModel> getVideo() async{
    try {
      var response = await dioAuthorizationData(token!).get('${Apis.baseUrl}${Apis.getYouTubeVideo}');
      print("--- Video Response ---");
      print(response);
      return VideoModel(status: false,data: null, msg: 'testing');
      // return VideoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}