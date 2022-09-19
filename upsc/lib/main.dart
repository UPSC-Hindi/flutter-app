import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:upsc/screens/SignUp.dart';
import 'package:upsc/screens/SignIn.dart';
import 'package:upsc/screens/cartscreeen.dart';
import 'package:upsc/screens/coursescreen.dart';
import 'package:upsc/screens/download.dart';
import 'package:upsc/screens/editprofile.dart';
import 'package:upsc/screens/helpandsupport.dart';
import 'package:upsc/screens/home.dart';
import 'package:upsc/screens/languagescreen.dart';
import 'package:upsc/screens/mocktestscreen.dart';
import 'package:upsc/screens/myorders.dart';
import 'package:upsc/screens/notifications.dart';
import 'package:upsc/screens/otpverification.dart';
import 'package:upsc/screens/profile.dart';
import 'package:upsc/screens/resources.dart';

import 'screens/mycourses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const Splash(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        'SignIn': (context) => const loginscreen(), //SignIn(),
        'SignUp': (context) => const SignUp(),
        'otpverification': (context) => const Otpverification(),
        'languagescreen': (context) => const LanguageScreen(),
        'home': (context) => const HomeScreen(),
        'notifications': (context) => const NotificationScreen(),
        'homescreen': (context) => const HomeScreen(),
        'Coursescreen': (context) => const coursescreen(),
        'mocktestscreen': (context) => const mocktestscreen(),
        'ProfilScreen': (context) => const ProfilScreen(),
        'editprofilescreen': (context) => const EditProfileScreen(),
        'downloadScreen': (context) => const DownloadScreen(),
        'resourcesscreen': (context) => const ResourcesScreen(),
        'cartscreen': (context) => const CartScreen(),
        'mycoursesscreen': (context) => const MyCoursesScreen(),
        'myordersscreen': (context) => const MyOrdersScreen(),
        'helpandsupport': (context) => const HelpAndSupport(),
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const loginscreen(),
      duration: 3000,
      //imageSize: 130,
      imageSrc: "assets/images/logo_Splash.jpg",
      backgroundColor: Colors.white,
    );
  }
}
