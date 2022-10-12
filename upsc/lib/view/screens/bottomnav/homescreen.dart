import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/bloc/video/video_bloc.dart';
import 'package:upsc/view/screens/bottomnav/ncert.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Daily Current Affairs',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Text(
                      'Revising and updating on current affairs will help you save your time',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Start Now',
                              style: GoogleFonts.poppins()), // <-- Text
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                Languages.learnAbout,
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ],
                          color: const Color(0xffF1F1F1)),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              child: SvgPicture.network(SvgImages.notepaper)),
                          Container(
                            height: 60,
                            width: 159,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: ColorResources.buttoncolor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Prelims',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: ColorResources.textWhite),
                                ),
                                Text(
                                  'Syllabus, Best Strategies and more',
                                  style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: ColorResources.textWhite),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ],
                          color: const Color(0xffF1F1F1)),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              child: Image.network(SvgImages.intrview)),
                          Container(
                            height: 60,
                            width: 160,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: ColorResources.buttoncolor),
                            child: Column(
                              children: [
                                Text(
                                  'Interviews',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: ColorResources.textWhite),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ethics, Personality and Tone',
                                  style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: ColorResources.textWhite),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ],
                          color: const Color(0xffF1F1F1)),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              child: Image.network(SvgImages.intrview)),
                          Container(
                            height: 60,
                            width: 160,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: ColorResources.buttoncolor),
                            child: Column(
                              children: [
                                Text(
                                  'Interviews',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: ColorResources.textWhite),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ethics, Personality and Tone',
                                  style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      color: ColorResources.textWhite),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(
                Languages.ncertBatches,
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => VideoBloc(),
                            child: NcertScreen(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                            color: ColorResources.youtube,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(SvgImages.youtube),
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("https://t.me/upschindi4cs"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          color: ColorResources.telegarm,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(SvgImages.telegram),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(
                Languages.latestNews,
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ),
            Center(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(SvgImages.youtube),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'News : 14 November',
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Read now',
                                  style: GoogleFonts.poppins(
                                      color: ColorResources.buttoncolor),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: ColorResources.buttoncolor)
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Got a Query?',
                        style: GoogleFonts.poppins(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorResources.buttoncolor,
                        ),
                        child: TextButton(
                          child: Text(
                            'Contact Us',
                            style: GoogleFonts.poppins(
                                color: ColorResources.textWhite),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed("contactus");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
