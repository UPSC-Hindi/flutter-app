import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class OurAchievementsScreen extends StatelessWidget {
  const OurAchievementsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Our Achievements',
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: const Center(
        child: Text('OurAchievementsScreen Update it soon...............'),
      ),
    );
  }
}
