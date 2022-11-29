import 'package:flutter/material.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/utils.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Util.blackColor,
          ),
        ),
      ),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: AppRoute.splashScreen,
    );
  }
}

