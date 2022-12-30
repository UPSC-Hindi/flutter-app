import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/cubit/bottom_tab/bottom_tab_cubit.dart';
import 'package:upsc_web/features/view/cubit/courses/courses_cubit.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/features/view/cubit/profile/cubit/profile_cubit.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
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
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<BottomTabCubit>(
          create: (context) => BottomTabCubit(),
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
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorResources.textblack),
            headline3: GoogleFonts.notoSansDevanagari(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorResources.textblack,
            ),

            //White Text
            headline4: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
              bodyText1:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
              bodyText2: GoogleFonts.notoSansDevanagari(
              fontSize: 20,
            ),
            headlineLarge: GoogleFonts.notoSansDevanagari(
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
          appBarTheme: AppBarTheme(
            color: ColorResources.textWhite,
            titleTextStyle: GoogleFonts.notoSansDevanagari(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorResources.textblack),
            iconTheme: IconThemeData(
              color: ColorResources.textblack,
            ),
            elevation: 0,
          ),
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: AppRoute.splashScreen,
      ),
    );
  }
}
