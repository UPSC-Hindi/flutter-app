import 'package:flutter/material.dart';
import 'package:upsc_web/features/view/screen/home/mobile_home.dart';
import 'package:upsc_web/features/view/screen/home/tab_home.dart';
import 'package:upsc_web/features/view/screen/home/web_home.dart';
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
