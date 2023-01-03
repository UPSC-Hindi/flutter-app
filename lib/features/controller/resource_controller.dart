import 'package:upsc_web/features/model/resources_model/air_resources_model.dart';
import 'package:upsc_web/features/model/resources_model/course_index_model.dart';
import 'package:upsc_web/features/model/resources_model/daily_news_model.dart';
import 'package:upsc_web/features/model/resources_model/notes_model.dart';
import 'package:upsc_web/features/model/resources_model/youtube_notes.dart';
import 'package:upsc_web/services/remote_services/resource_services.dart';
import 'package:upsc_web/utils.dart';

class ResourceController {
  ResourceServices resourceServices = ResourceServices();
  Future<DailyNewsModel> getDailyNews() async {
    try {
      dynamic response = await resourceServices.dailyNewsService();
      return DailyNewsModel.fromJson(response);
    } catch (error) {
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<NotesModel> getNotes({required String filter}) async {
    try {
      dynamic response =
          await resourceServices.getNotesService({"Notes_type": filter});
      return NotesModel.fromJson(response);
    } catch (error) {
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<VideoModel> getYoutubeNotes() async {
    try {
      dynamic response = await resourceServices.getYouTubeVideoService();
      return VideoModel.fromJson(response);
    } catch (error) {
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<AirResourcesModel> getAirResource() async {
    try {
      dynamic response = await resourceServices.getAirREsourceService();
      return AirResourcesModel.fromJson(response);
    } catch (error) {
      Util.toastMessage(error.toString());
      rethrow;
    }
  }

  Future<CourseIndexModel> getCourseIndex() async {
    try {
      dynamic response = await resourceServices.getCourseIndexService();
      return CourseIndexModel.fromJson(response);
    } catch (error) {
      Util.toastMessage(error.toString());
      rethrow;
    }
  }
}
