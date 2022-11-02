import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/util/langauge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/SignIn.dart';
import 'package:upsc/view/screens/auth/SignUp.dart';
import 'package:upsc/view/screens/auth/forgotpassword.dart';
import 'package:upsc/view/screens/auth/otpverification.dart';
import 'package:upsc/view/screens/auth/passwordVerified.dart';
import 'package:upsc/view/screens/auth/passwordchange.dart';
import 'package:upsc/view/screens/auth/passwordotp.dart';
import 'package:upsc/view/screens/bottomnav/coursescreen.dart';
import 'package:upsc/view/screens/bottomnav/editprofile.dart';
import 'package:upsc/view/screens/bottomnav/mocktestscreen.dart';
import 'package:upsc/view/screens/bottomnav/ncert.dart';
import 'package:upsc/view/screens/bottomnav/profile.dart';
import 'package:upsc/view/screens/contactus.dart';
import 'package:upsc/view/screens/home.dart';
import 'package:upsc/view/screens/bottomnav/homescreen.dart';
import 'package:upsc/view/screens/languagescreen.dart';
import 'package:upsc/view/screens/notifications.dart';
import 'package:upsc/view/screens/sidenav/aboutus.dart';
import 'package:upsc/view/screens/sidenav/cartscreeen.dart';
import 'package:upsc/view/screens/sidenav/download.dart';
import 'package:upsc/view/screens/sidenav/helpandsupport.dart';
import 'package:upsc/view/screens/sidenav/mycourses.dart';
import 'package:upsc/view/screens/sidenav/myorders.dart';
import 'package:upsc/view/screens/sidenav/myschedule.dart';
import 'package:upsc/view/screens/sidenav/myscheduleadd.dart';
import 'package:upsc/view/screens/sidenav/resources.dart';
import 'package:upsc/view/screens/sidenav/resources/dailynews.dart';
import 'package:upsc/view/screens/sidenav/resources/samplenotes.dart';
import 'package:upsc/view/screens/sidenav/resources/shortnotes.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:upsc/view/screens/sidenav/resources/youtubenotes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  //Orientations
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  //FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      await SharedPreferenceHelper.init();
      //Languages.isEnglish = SharedPreferenceHelper.getString(Preferences.language)! == "English" ? false : true;
      await Languages.initState();
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const Splash(),
        initialRoute: '/',
        navigatorKey: navigatorKey,

        routes: {
          '/': (context) => const Splash(),
          'home': (context) => const HomeScreen(),
          'SignIn': (context) => const loginscreen(), //SignIn(),
          'SignUp': (context) => const SignUp(),
          'otpverification': (context) => Otpverification(
                number: '',
              ),
          'languagescreen': (context) => const LanguageScreen(
                isLogin: false,
              ),
          'notifications': (context) => const NotificationScreen(),
          'homescreen': (context) => const HomeScreens(),
          'Coursescreen': (context) => const CourseScreen(),
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
          'passwordotp': (context) => PasswordOtp(
                Otpfor: '',
              ),
          'passwordverified': (context) => passwordVerified(
                type: '',
              ),
          'passwordchange': (context) => const PasswordChange(),
          'ncertscreen': (context) => const NcertScreen(),
          'MySchedule': (context) => const MySchedule(),
          'MyScheduleAdd': (context) => const MyScheduleAdd(),
          'dailynews': (context) => const DailyNewsScreen(),
          'shortnotes': (context) => const ShortNotesScreen(),
          'youtubenotes': (context) => const YoutubeNotesScreen(),
          'samplenotes': (context) => const SampleNotesScreen(),
          'contactus': (context) => const ContactUsScreen(),
          'aboutusscreen': (context) => const AboutUsScreen(),
//           'joinstreaming': (context) => const JoinStreamingScreen(
// lecture: '',
//                 rtctoken: '',
//                 rtmtoken: '',
//                 uid: 0,
//               ),
        },
      ),
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
      navigateRoute: SharedPreferenceHelper.getBoolean(Preferences.is_logged_in)
          ? const HomeScreen()
          : const loginscreen(),
      //duration: 30,
      //imageSize: 130,
      imageSrc: "assets/images/splash.gif",
      backgroundColor: Colors.white,
    );
  }
}