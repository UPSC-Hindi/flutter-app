

import 'package:flutter/cupertino.dart';
import 'package:upsc_web/features/model/baneer_model.dart';
import 'package:upsc_web/services/remote_services/remote_services.dart';
import 'package:upsc_web/utils/utils.dart';

class GlobalController{
  static Future<List<Widget>>getBanner()async{
    List<Widget>imageList = [];
    await RemoteServices.getBannerApi().then((value) {
      BannerModel response = BannerModel.fromJson(value);
      if(response.status){
        for (var entry in response.data) {
          imageList.add(Image.network(entry.bannerUrl.first));
        }
      }else{
        Utils.toastMessage(response.msg);
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
    return imageList;
  }
}