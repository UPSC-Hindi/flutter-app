import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Preferences {
  Preferences._();

    static const String is_logged_in = "isLoggedIn";
  static const String name = "name";
  static const String auth_token = "authToken";
  static const String access_token = "accessToken";
  static const String password_change_data = "Passwordchangedata";
  static const String language = 'language';
  static const String course = 'course';
  static const String email = 'email';
  static const String phoneNUmber = 'phoneNUmber';
  static const String device_platform='device_platform';
   static const String profileImage = 'profileImage';
  static const String address = 'address';

   static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
  
  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
  }

  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("PleaseWait"),
              ],
            ),
          ),
        );
      },
    );
  }
}
