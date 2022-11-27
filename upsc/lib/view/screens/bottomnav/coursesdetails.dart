import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class CoursesDetailsScreens extends StatefulWidget {
  final CoursesDataModel course;

  CoursesDetailsScreens({Key? key, required this.course}) : super(key: key);

  @override
  State<CoursesDetailsScreens> createState() => _CoursesDetailsScreensState();
}

class _CoursesDetailsScreensState extends State<CoursesDetailsScreens> {
  List<Widget> image = [];

  @override
  void initState() {
    widget.course.banner.forEach((element) {
      image.add(Image.network(element.fileLoc));
    });
    print(image.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context, widget.course);
  }

  Scaffold _bodyWidget(BuildContext context, CoursesDataModel course) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          widget.course.batchName,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CarouselSlider(
                  items: image,
                  options: CarouselOptions(
                    height: 140,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.course.remark.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFfD9D9D9),
                                      borderRadius: BorderRadius.circular(90)),
                                  child: Text(
                                    '  remark  ',
                                    style: GoogleFonts.notoSansDevanagari(
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15),
                                  child: Text(
                                    course.remark,
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            )
                          : Text(''),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Course Details  ',
                          style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          course.description,
                          style: GoogleFonts.lato(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 20 / 4,
                        shrinkWrap: true,
                        children: [
                          Row(children: const [
                            Icon(
                              Icons.play_circle_fill_outlined,
                            ),
                            Text('  75 Video Lectures')
                          ]),
                          Row(children: const [
                            Icon(
                              Icons.book,
                            ),
                            Text(' 25 Readings')
                          ]),
                          Row(children: [
                            Icon(
                              Icons.sensors_outlined,
                              color: ColorResources.buttoncolor,
                            ),
                            Text(" ${widget.course.mode}") //' Live Access')
                          ]),
                          Row(children: [
                            const Icon(
                              Icons.people,
                            ),
                            Text(' ${widget.course.student.length} Student')
                          ]),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Duration  ',
                          style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                        ),
                      ),
                      GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 20 / 4,
                          shrinkWrap: true,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.access_time_rounded,
                              ),
                              Text(
                                  '  ${course.endingDate.difference(course.startingDate).inDays} Days')
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                              ),
                              Text(
                                  ' Starts : ${DateFormat("dd-MM-yyyy").format(course.startingDate)}')
                            ]),
                          ]),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Container(
                      //     margin: const EdgeInsets.all(10),
                      //     padding: const EdgeInsets.all(5),
                      //     decoration: BoxDecoration(
                      //         color: const Color(0xFfD9D9D9),
                      //         borderRadius: BorderRadius.circular(90)),
                      //     child: Text(
                      //       '  Faculty  ',
                      //       style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 110,
                      //   child: ListView.builder(
                      //     itemCount: course.teacher.length,
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (context, index) => Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      //       child: Column(
                      //         children: [
                      //           Image.network(
                      //             'https://storage-upschindi.s3.ap-south-1.amazonaws.com/data/images/avatar.png',
                      //             height: 80,
                      //           ),
                      //           Text(
                      //             course.teacher[index].fullName,
                      //             style: GoogleFonts.notoSansDevanagari(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Watch Demos  ',
                          style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                color: ColorResources.gray,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.account_circle_rounded,
                                      size: 80,
                                    ),
                                    Text('Raman Deep',
                                        style: GoogleFonts.notoSansDevanagari(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '₹${course.charges}',
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ColorResources.buttoncolor,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            callApiaddtocart(course);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 5.0),
                            child: Text('Add to Cart',
                                style: GoogleFonts.notoSansDevanagari(
                                    fontSize: 20)),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callApiaddtocart(CoursesDataModel course) async {
    AddToCart response;
    Map<String, dynamic> body = {
      "batch_id": widget.course.id,
    };
    try {
      setState(() {
        Preferences.onLoading(context);
      });
      var token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
     Response response =  await dioAuthorizationData().post(
        '${Apis.baseUrl}${Apis.addtocart}',
        data: body,
      );
      if (response.data['status']) {
        setState(() {
          Preferences.hideDialog(context);
        });
        Navigator.of(context).popAndPushNamed('cartscreen');
        Fluttertoast.showToast(
          msg: '${response.data['msg']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${response.data['msg']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });

    }
  }
}
