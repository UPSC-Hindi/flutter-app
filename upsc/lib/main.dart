import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:upsc/screens/auth/SignIn.dart';
import 'package:upsc/screens/auth/SignUp.dart';
import 'package:upsc/screens/auth/passwordVerified.dart';
import 'package:upsc/screens/auth/passwordchange.dart';
import 'package:upsc/screens/auth/passwordotp.dart';
import 'package:upsc/screens/bottomnav/coursescreen.dart';
import 'package:upsc/screens/bottomnav/editprofile.dart';
import 'package:upsc/screens/bottomnav/mocktestscreen.dart';
import 'package:upsc/screens/bottomnav/ncert.dart';
import 'package:upsc/screens/bottomnav/profile.dart';
import 'package:upsc/screens/sidenav/cartscreeen.dart';
import 'package:upsc/screens/contactus.dart';
import 'package:upsc/screens/sidenav/myschedule.dart';
import 'package:upsc/screens/sidenav/myscheduleadd.dart';
import 'package:upsc/screens/sidenav/resources/dailynews.dart';
import 'package:upsc/screens/sidenav/download.dart';
import 'package:upsc/screens/auth/forgotpassword.dart';
import 'package:upsc/screens/sidenav/helpandsupport.dart';
import 'package:upsc/screens/home.dart';
import 'package:upsc/screens/languagescreen.dart';
import 'package:upsc/screens/sidenav/myorders.dart';
import 'package:upsc/screens/notifications.dart';
import 'package:upsc/screens/auth/otpverification.dart';
import 'package:upsc/screens/sidenav/resources.dart';
import 'package:upsc/screens/sidenav/resources/samplenotes.dart';
import 'package:upsc/screens/sidenav/resources/shortnotes.dart';
import 'package:upsc/screens/sidenav/resources/youtubenotes.dart';


import 'screens/sidenav/mycourses.dart';

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
        'home': (context) => const HomeScreen(),
        'SignIn': (context) => const loginscreen(), //SignIn(),
        'SignUp': (context) => const SignUp(),
        'otpverification': (context) => Otpverification(
              number: '',
            ),
        'languagescreen': (context) => const LanguageScreen(),
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
        'forgotpasswordscreen': (context) => const ForgotPasswordScreen(),
        'passwordotp': (context) =>  PasswordOtp(Otpfor: '',),
        'passwordverified': (context) => passwordVerified(type: '',),
        'passwordchange': (context) => const PasswordChange(),
        'ncertscreen': (context) => const NcertScreen(),
        'MySchedule': (context) => const MySchedule(),
        'MyScheduleAdd': (context) => const MyScheduleAdd(),
        'dailynews': (context) => const DailyNewsScreen(),
        'shortnotes': (context) => const ShortNotesScreen(),
        'youtubenotes': (context) => const YoutubeNotesScreen(),
        'samplenotes': (context) => const SampleNotesScreen(),
        'contactus': (context) => const ContactUsScreen(),
      },
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: loginscreen(),
      duration: 3000,
      //imageSize: 130,
      imageSrc: "assets/images/logo_Splash.jpg",
      backgroundColor: Colors.white,
    );
  }
}
