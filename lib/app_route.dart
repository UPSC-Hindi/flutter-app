import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/features/model/courses_model/CartCoursesModel.dart';
import 'package:upsc_web/features/view/courses_payement_screen.dart';
import 'package:upsc_web/features/view/screen/auth/language_screen.dart';
import 'package:upsc_web/features/view/screen/auth/otp_verification_screen.dart';
import 'package:upsc_web/features/view/screen/auth/sign_in_screen.dart';
import 'package:upsc_web/features/view/screen/auth/sign_up_screen.dart';
import 'package:upsc_web/features/view/screen/home/contactus_screen.dart';
import 'package:upsc_web/features/view/screen/home_screen.dart';
import 'package:upsc_web/features/view/screen/side_nav/about_us_screen.dart';
import 'package:upsc_web/features/view/screen/side_nav/help_and_support_screen.dart';
import 'package:upsc_web/features/view/screen/side_nav/my_cart_screen.dart';
import 'package:upsc_web/features/view/screen/side_nav/my_courses_screen.dart';
import 'package:upsc_web/features/view/screen/side_nav/resources/daily_news_resources.dart';
import 'package:upsc_web/features/view/screen/side_nav/resources/short_notes_resources.dart';
import 'package:upsc_web/features/view/screen/side_nav/resources_screen.dart';
import 'features/view/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/';
  static const String signInScreen = 'signInScreen';
  static const String signupScreen = 'signupScreen';
  static const String homeScreen = 'homeScreen';
  static const String otpVerificationScreen = 'otpVerificationScreen';
  static const String languageScreen = 'languageScreen';
  static const String myCartScreen = 'myCartScreen';
  static const String myCoursesScreen = 'myCoursesScreen';
  static const String coursePaymentScreen = 'coursePaymentScreen';
  static const String aboutUsScreen = 'aboutUsScreen';
  static const String helpAndSupport = 'helpAndSupport';
  static const String contactUs = 'contactUs';

  //RESOURCES SCREEN
  static const String resourcesScreen = 'resourcesScreen';
  static const String dailyNews = 'dailyNews';
  static const String shortNotes = 'shortNotes';
}

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    ResourceController resourceController = ResourceController();
    switch (settings.name) {
      case AppRoute.splashScreen:
        return cupertinoBuilder(widget: const SplashScreen());

      case AppRoute.signInScreen:
        return cupertinoBuilder(widget: const SignInScreen());

      case AppRoute.signupScreen:
        List<Widget> bannerList = args as List<Widget>;
        return cupertinoBuilder(widget: SignUpScreen(bannerList: bannerList));

      case AppRoute.homeScreen:
        return cupertinoBuilder(widget: const HomeScreen());

      case AppRoute.myCartScreen:
        return cupertinoBuilder(widget: const MyCartScreen());

      case AppRoute.myCoursesScreen:
        return cupertinoBuilder(widget: const MyCoursesScreen());

      case AppRoute.otpVerificationScreen:
        List data = args as List;
        List<Widget> bannerList = data.first;
        String userNumber = data.last;
        return cupertinoBuilder(
          widget: OtpVerificationScreen(
            bannerList: bannerList,
            userNumber: userNumber,
          ),
        );

      case AppRoute.languageScreen:
        return cupertinoBuilder(widget: const LanguageScreen());

      case AppRoute.coursePaymentScreen:
        MyCartCoursesDataModel courseData = args as MyCartCoursesDataModel;
        return CupertinoPageRoute(
          builder: (context) => CoursePaymentScreen(course: courseData),
        );

      case AppRoute.aboutUsScreen:
        return cupertinoBuilder(widget: AboutUsScreen());

      case AppRoute.helpAndSupport:
        return cupertinoBuilder(widget: const HelpAndSupportScreen());

      case AppRoute.contactUs:
        return cupertinoBuilder(widget: const ContactUsScreen());

      case AppRoute.resourcesScreen:
        return cupertinoBuilder(widget: const ResourcesScreen());

      case AppRoute.dailyNews:
        return cupertinoBuilder(
            widget: DailyNewsScreen(resourceController: resourceController));
      case AppRoute.shortNotes:
        return cupertinoBuilder(
            widget: ShortNotesScreen(
          resourceController: resourceController,
        ));

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
