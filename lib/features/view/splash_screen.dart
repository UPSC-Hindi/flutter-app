import 'package:flutter/material.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    changeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/splash.gif"),
      ),
    );
  }
  void changeScreen(){
    Future.delayed(const Duration(seconds: 3),() {
      isLogin = PreferencesHelper.getBoolean(Preferences.isLoggedIn);
      isLogin?Navigator.popAndPushNamed(context, AppRoute.homeScreen):
      Navigator.popAndPushNamed(context, AppRoute.signInScreen);
    });
  }
}