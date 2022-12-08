import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/features/view/screen/home/mobile_home.dart';
import 'package:upsc_web/features/view/screen/home/tab_home.dart';
import 'package:upsc_web/features/view/screen/home/web_home.dart';
import 'package:upsc_web/features/view/screen/side_bar/my_cart_screen.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileHome(),
      web: WebHome(),
      tab: TabHome(),
    );
  }
}
