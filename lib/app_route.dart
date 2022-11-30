
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upsc_web/features/view/screen/auth/sign_in_screen.dart';
import 'package:upsc_web/features/view/screen/auth/sign_up_screen.dart';
import 'package:upsc_web/features/view/screen/splash_screen.dart';

class AppRoute{
  static const String splashScreen = '/';
  static const String signInScreen = 'signInScreen';
  static const String signupScreen = 'signupScreen';
}
class OnGenerateRoute{
  static Route<dynamic> route(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
        case AppRoute.splashScreen:
          return cupertinoBuilder(widget: const SplashScreen());

        case AppRoute.signInScreen:
          return cupertinoBuilder(widget: const SignInScreen());

        case AppRoute.signupScreen:
          return cupertinoBuilder(widget: const SignUpScreen());

      default:
        return cupertinoBuilder(
          widget: ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

CupertinoPageRoute cupertinoBuilder({required Widget widget}) {
  return CupertinoPageRoute(builder: (_) => widget);
}