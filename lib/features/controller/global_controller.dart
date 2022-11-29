

import 'package:flutter/cupertino.dart';
import 'package:upsc_web/services/remote_services/remote_services.dart';

class GlobalController{
  static Future<List<Widget>>getBanner()async{
    List<Widget>imageList = [];
    await RemoteServices.getBannerApi().then((value) {
      for (var entry in value['data']) {
        imageList.add(Image.network(entry['banner_url'][0]));
      }
    }).onError((error, stackTrace) {
      throw error!;
    });
    return imageList;
  }
}