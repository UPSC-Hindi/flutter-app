import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/global_controller.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(mobile: Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 5)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<List<Widget>>(
                    future: GlobalController.getBanner("web"),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.done) {
                        if (snapshots.hasData) {
                          return CarouselSlider(
                            items: snapshots.data,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        } else if (snapshots.hasError) {}
                        return Text('Something went wrong');
                      } else {
                        return Center();
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Current Affairs',
                          style: GoogleFonts.notoSansDevanagari(
                              fontSize: 14,
                              color: ColorResources.textblack,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'dailynews');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' Explore ',
                                  style: GoogleFonts.notoSansDevanagari(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ), // <-- Text
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
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          height: 21,
                          SvgImages.currentaffer2,
                          width: MediaQuery.of(context).size.height * 0.19,
                        ),
                        Image.network(
                          height: 21,
                          SvgImages.currentaffer1,
                          width: MediaQuery.of(context).size.height * 0.19,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  Languages.myCourses,
                  style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorResources.textblack),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                height: 140,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Languages.latestNews,
                      style: GoogleFonts.notoSansDevanagari(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorResources.textblack),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' Explore ',
                              style: GoogleFonts.notoSansDevanagari(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ), // <-- Text
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
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 120,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                padding: const EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 15),
                child: Text(
                  Languages.ncertBatches,
                  style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.bold,
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
                        launchUrl(
                            Uri.parse(
                                "https://www.youtube.com/c/GauravTripathiiitroorkee"),
                            mode: LaunchMode.externalApplication);
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
              const SizedBox(
                height: 20,
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
                          style: GoogleFonts.notoSansDevanagari(),
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
                              style: GoogleFonts.notoSansDevanagari(
                                  fontSize: 20,
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
      ),
    ), web: Text('Web not completed'), tab: Text("dasdsa"),);
  }
}
