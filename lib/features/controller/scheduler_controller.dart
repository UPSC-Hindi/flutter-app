

import 'package:upsc_web/features/model/scheduler_model/class_scheduler.dart';
import 'package:upsc_web/services/remote_services/scheduler_services.dart';
import 'package:upsc_web/utils.dart';

class SchedulerController{
  SchedulerServices schedulerServices = SchedulerServices();
  Future<ClassSchedulerModel>getClassScheduler()async{
    try{
      dynamic jsonResponse = await schedulerServices.getClassSchedulerService();
      ClassSchedulerModel response = ClassSchedulerModel.fromJson(jsonResponse);
      Util.flutterToast(response.msg!);
      return response;
    }catch(error){
      rethrow;
    }
  }
}