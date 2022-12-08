import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UPSC HINDI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:const TextTheme(
            headlineMedium: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Utils.blackColor,
            ),
          ),
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: AppRoute.splashScreen,
      ),
    );
  }
}
