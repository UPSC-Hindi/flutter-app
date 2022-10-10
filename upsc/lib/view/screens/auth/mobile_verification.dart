import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';

import '../../../util/images_file.dart';

class MobileVerification extends StatelessWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            items: [
              Image.asset(
                SvgImages.banner_1,
              ), // SvgPicture.asset(SvgImages.banner_1,),
              Image.asset(
                  SvgImages.banner_2), // SvgPicture.asset(SvgImages.banner_2),
              Image.asset(
                  SvgImages.banner_3), // SvgPicture.asset(SvgImages.banner_3),
              Image.asset(SvgImages.banner_4),
              // SvgPicture.asset(SvgImages.banner_4),
            ],
            options: CarouselOptions(
              height: 250,
              aspectRatio: 16 / 9,
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
            height: 20,
          ),
          const Text(
            'Verify Your Phone Number',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10
            ),
            child: TextField(
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Mobile Number',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            margin: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                color: ColorResources.buttoncolor,
                borderRadius: BorderRadius.circular(14)),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Send OTP',
                style: GoogleFonts.poppins(
                    color: ColorResources.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
