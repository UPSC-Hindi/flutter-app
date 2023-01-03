import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/utils.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({Key? key, required this.images}) : super(key: key);
  final List<Widget> images;

  @override
  Widget build(BuildContext context) {
    String mobileNumber = '';
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: Column(
          children: [
            CarouselSlider(
              items: images,
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Verify Your Phone Number',
              style: GoogleFonts.notoSansDevanagari(
                  fontWeight: FontWeight.w900, fontSize: 24),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  mobileNumber = value;
                },
                style: GoogleFonts.notoSansDevanagari(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Mobile Number',
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              margin: const EdgeInsets.symmetric(vertical: 35),
              decoration: BoxDecoration(
                  color: ColorResources.buttoncolor,
                  borderRadius: BorderRadius.circular(14)),
              child: TextButton(
                onPressed: () {
                  if(mobileNumber.length==10){
                    Navigator.pushNamed(context, AppRoute.otpVerificationScreen,
                        arguments: [images, mobileNumber]);
                  }else{
                    Utils.toastMessage('Enter the valid Number');
                  }
                },
                child: Text(
                  'Send OTP',
                  style: GoogleFonts.notoSansDevanagari(
                    color: ColorResources.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
