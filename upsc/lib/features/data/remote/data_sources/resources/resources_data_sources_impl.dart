import 'package:dio/dio.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/resources/resources_data_source.dart';
import 'package:upsc/features/data/remote/models/air_resource_model.dart';
import 'package:upsc/features/data/remote/models/daily_news_model.dart';
import 'package:upsc/features/data/remote/models/notes_model.dart';
import 'package:upsc/features/data/remote/models/resources_model.dart';

class ResourceDataSourceImpl extends ResourcesDataSource {
  @override
  getDailyNews() async {
    try {
      Response response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getDailyNews}');
      return DailyNewsModel.fromJson(response.data);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  getAir() async {
    try {
      Response response = await dioAuthorizationData()
          .get('${Apis.baseUrl}${Apis.getAirResources}');
      return AirResourcesModel.fromJson(response.data);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  getCourseIndex() async {
    try {
      Response response = await dioAuthorizationData()
           .get('${Apis.baseUrl}${Apis.getCourseIndex}');
      return ResourcesModel.fromJson(response.data);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  Future<NotesModel> getNotes({required String filter}) async {
    try {
      Response response = await dioAuthorizationData().get(
          '${Apis.baseUrl}${Apis.getNotesDetails}',
          queryParameters: {"Notes_type": filter});
      return NotesModel.fromJson(response.data);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  void getYoutubeNotes() {
    // TODO: implement getYoutubeNotes
  }
}