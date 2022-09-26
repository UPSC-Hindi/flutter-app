import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'My Orders',
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: Center(
        child: Text('MyOrdersScreen'),
      ),
    );
  }
}
