import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'NotificationScreen',
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: Center(
        child: Text('NotificationScreen'),
      ),
    );
  }
}
