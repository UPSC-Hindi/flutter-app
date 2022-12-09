import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';

class TestSubmitScreen extends StatelessWidget {
  const TestSubmitScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'TestSubmitScreen',
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('TestSubmitScreen'),
      ),
    );
  }
}
