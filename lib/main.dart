import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/cubit/courses/courses_cubit.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/utils.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
        BlocProvider<CoursesCubit>(
          create: (context) => CoursesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UPSC HINDI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.notoSansDevanagari(
                color: ColorResources.textblack,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            headline2: GoogleFonts.notoSansDevanagari(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorResources.textblack),
            headlineLarge: GoogleFonts.notoSansDevanagari(
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: AppRoute.splashScreen,
      ),
    );
  }
}
