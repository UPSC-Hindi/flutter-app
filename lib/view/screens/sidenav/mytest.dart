import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class MyTestSeries extends StatelessWidget {
  const MyTestSeries({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'My TestSeries',
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: const Center(
        child: Text('NO MyTestSeries'),
      ),
    );
  }
}
