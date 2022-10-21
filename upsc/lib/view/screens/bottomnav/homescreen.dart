import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/bottomnav/ncert.dart';
import 'package:upsc/view/screens/sidenav/resources/dailynews.dart';
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
                color: ColorResources.textWhite,
                boxShadow: [
                  BoxShadow(
                      color: ColorResources.gray.withOpacity(0.5),
                      blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Daily Current Affairs',
                    style: TextStyle(
                        fontSize: 20, color: ColorResources.textblack),
                  ),
                  const SizedBox(height: 5),
                  Text(
                      'Revising and updating on current affairs will help you save your time',
                      style: GoogleFonts.lato(
                          fontSize: 14, color: ColorResources.textblack)),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const DailyNewsScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Start Now',
                              style: GoogleFonts.poppins()), // <-- Text
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ColorResources.gray.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                Languages.learnAbout,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorResources.textblack),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: ColorResources.textWhite,
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.gray.withOpacity(0.5),
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal)
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                                height: 100,
                                child: SvgPicture.network(SvgImages.notepaper)),
                            Container(
                              height: 60,
                              width: 159,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: ColorResources.buttoncolor),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Prelims',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: ColorResources.textWhite),
                                  ),
                                  Text(
                                    'Syllabus, Best Strategies and more',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
                          color: ColorResources.textWhite,
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.gray.withOpacity(0.5),
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal)
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: ColorResources.textWhite),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ethics, Personality and Tone',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
                          color: ColorResources.textWhite,
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.gray.withOpacity(0.5),
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal)
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: ColorResources.textWhite),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ethics, Personality and Tone',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(
                Languages.ncertBatches,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorResources.textblack),
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
                          builder: (context) => const NcertScreen(),
                        ),
                      );
                    },
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                            color: ColorResources.youtube,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorResources.gray.withOpacity(0.5),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.normal)
                            ],
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
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.gray.withOpacity(0.5),
                                blurRadius: 5,
                                blurStyle: BlurStyle.normal)
                          ],
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
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: Text(
                Languages.latestNews,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorResources.textblack),
              ),
            ),
            Center(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: ColorResources.textWhite,
                  boxShadow: [
                    BoxShadow(
                        color: ColorResources.gray.withOpacity(0.5),
                        blurRadius: 5,
                        blurStyle: BlurStyle.normal)
                  ],
                  borderRadius: BorderRadius.circular(20),
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
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorResources.textblack),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Read now ',
                                  style: GoogleFonts.poppins(
                                      color: ColorResources.buttoncolor),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 15, color: ColorResources.buttoncolor)
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
                    color: ColorResources.textWhite,
                    boxShadow: [
                      BoxShadow(
                          color: ColorResources.gray.withOpacity(0.5),
                          blurRadius: 5,
                          blurStyle: BlurStyle.normal)
                    ],
                    borderRadius: BorderRadius.circular(20),
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
