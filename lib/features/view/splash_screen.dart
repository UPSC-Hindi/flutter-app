import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/course_tab.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    PreferencesHelper.init().then((value) {
      print("Changing the screen");
        bool isLogin = PreferencesHelper.getBoolean(Preferences.isLoggedIn);
        isLogin?Navigator.popAndPushNamed(context, AppRoute.homeScreen):
        Navigator.popAndPushNamed(context, AppRoute.signInScreen);
        print("Success change the screen");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
