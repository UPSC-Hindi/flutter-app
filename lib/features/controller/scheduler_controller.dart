

import 'package:device_info_plus/device_info_plus.dart';
import 'package:upsc_web/features/model/scheduler_model/class_scheduler_model.dart';
import 'package:upsc_web/features/model/scheduler_model/my_scheduler_model.dart';
import 'package:upsc_web/services/base_api/base_client.dart';
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

  Future<MySchedulerModel>getMyScheduler()async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    final queryParameters = <String, dynamic>{"deviceId": webInfo.userAgent};
    try {
      dynamic jsonResponse = await schedulerServices.getMySchedulerService(queryParameters);
      MySchedulerModel response = MySchedulerModel.fromJson(jsonResponse);
      Util.flutterToast(response.msg);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}