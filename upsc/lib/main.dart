import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:upsc/screens/SignUp.dart';
import 'package:upsc/screens/SignIn.dart';
import 'package:upsc/screens/home.dart';
import 'package:upsc/screens/languagescreen.dart';
import 'package:upsc/screens/notifications.dart';
import 'package:upsc/screens/otpverification.dart';

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
        'home':(context) => const HomeScreen(),
        'notifications':(context) => const NotificationScreen(),
        
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
