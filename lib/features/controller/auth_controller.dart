import 'package:device_info_plus/device_info_plus.dart';
import 'package:upsc_web/services/remote_services/auth_services.dart';

class AuthController{
  final AuthServices authServices;
  AuthController(this.authServices);

  Future<void>login()async{
    await authServices.loginServices('').then((value) async{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // final deviceName = androidInfo.brand;
      // final deviceConfig = androidInfo.id;
      print('web info');
      print(webBrowserInfo.appName);
      print(webBrowserInfo.appCodeName);
      print(webBrowserInfo.appVersion);
      print(webBrowserInfo.browserName);
      print(webBrowserInfo.deviceMemory);
      print(webBrowserInfo.platform);
      print(webBrowserInfo.product);
      print(webBrowserInfo.data);
      print(webBrowserInfo.userAgent);
      // write your code
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}