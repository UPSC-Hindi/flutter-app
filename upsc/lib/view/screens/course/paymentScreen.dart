import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/screens/home.dart';
import 'package:upsc/view/screens/sidenav/mycourses.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentfor;
  const PaymentScreen({Key? key,required this.paymentfor}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      widget.paymentfor=="course"?
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyCoursesScreen(),
        ),
      ):Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(index: 2,),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified,
              size: 200,
              color: ColorResources.buttoncolor,
            ),
            Text(
              'Thank You!',
              style: GoogleFonts.notoSansDevanagari(
                  color: ColorResources.textblack, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
