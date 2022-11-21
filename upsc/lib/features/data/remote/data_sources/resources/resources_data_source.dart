import 'package:upsc/features/data/remote/models/air_resource_model.dart';
import 'package:upsc/features/data/remote/models/daily_news_model.dart';
import 'package:upsc/features/data/remote/models/notes_model.dart';

abstract class ResourcesDataSource{
  Future<DailyNewsModel> getDailyNews();
  Future<NotesModel> getCourseIndex();
  void getYoutubeNotes();
  Future<NotesModel> getNotes();
  Future<AirResourcesModel> getAir();
}