import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/api.dart';
import 'package:upsc/features/data/const_data.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart'
    as rdsi;
import 'package:upsc/features/data/remote/models/course_details_model.dart';
import 'package:upsc/features/presentation/widgets/videopaler.dart';
import 'package:upsc/features/presentation/widgets/youtube_player_widget.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursesDetailsScreens extends StatefulWidget {
  final String courseId;
  final String courseName;
  CoursesDetailsScreens(
      {Key? key, required this.courseId, required this.courseName})
      : super(key: key);

  @override
  State<CoursesDetailsScreens> createState() => _CoursesDetailsScreensState();
}

class _CoursesDetailsScreensState extends State<CoursesDetailsScreens> {
  List<Widget> image = [];

  late Future<CoursesDetailsModel> _getCourseDetails;

  RemoteDataSource remoteDataSource = rdsi.RemoteDataSourceImpl();
  @override
  void initState() {
    _getCourseDetails = remoteDataSource.getCoursesDetails(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          widget.courseName,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<CoursesDetailsModel>(
          future: _getCourseDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                snapshot.data!.data.batchDetails.banner.forEach((element) {
                  image.add(Image.network(element.fileLoc));
                });
                return _bodyWidget(snapshot.data!);
              } else {
                return const Text('Check Your internet');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _bodyWidget(CoursesDetailsModel course) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
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
                            course.data.batchDetails.description,
                            style: GoogleFonts.lato(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        course.data.batchDetails.remark.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Note: ",
                                          style: GoogleFonts.notoSansDevanagari(
                                              fontSize: 20,
                                              color:
                                                  ColorResources.buttoncolor),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          child: Text(
                                            course.data.batchDetails.remark,
                                            style:
                                                GoogleFonts.lato(fontSize: 16),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : const Text(''),
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
                                Icons.play_circle_fill_outlined,
                              ),
                              Text('  ${course.data.noOfVideos} Video Lectures')
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.book,
                              ),
                              Text(' ${course.data.noofNotes} Readings')
                            ]),
                            Row(children: [
                              Icon(
                                Icons.sensors_outlined,
                                color: ColorResources.buttoncolor,
                              ),
                              Text(
                                  " ${course.data.batchDetails.mode}") //' Live Access')
                            ]),
                            Row(children: const [
                              Icon(
                                Icons.people,
                              ),
                              Text(' Best Recommended')
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
                                    '  ${course.data.batchDetails.endingDate.difference(course.data.batchDetails.startingDate).inDays} Days')
                              ]),
                              Row(children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                ),
                                Text(
                                    ' Starts : ${DateFormat("dd-MM-yyyy").format(course.data.batchDetails.startingDate)}')
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                course.data.batchDetails.demoVideo.length,
                            itemBuilder: (BuildContext context, int index) {
                              return videolist(
                                  course.data.batchDetails.demoVideo[index]);
                            },
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '₹${course.data.batchDetails.charges}',
                  style: GoogleFonts.notoSansDevanagari(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      callApiaddtocart(course.data.batchDetails.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 5.0),
                      child: Text('Add to Cart',
                          style: GoogleFonts.notoSansDevanagari(fontSize: 20)),
                    ))
              ],
            )),
      ],
    );
  }

  youtubevideo(url) {
    String videoId = YoutubePlayer.convertUrlToId(url)!;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YoutubePlayerWidget(
                  videoId: videoId,
                )));
  }

  Widget videolist(Banners demoVideo) {
    return InkWell(
      onTap: () {
        print("he");
        print(demoVideo.fileLoc);
        demoVideo.demoVideofileType == "Video"
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayVideoFromNetwork(
                    Videourl: demoVideo.fileLoc,
                  ),
                ),
              )
            : youtubevideo(demoVideo.fileLoc);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: ColorResources.gray.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.play_circle,
                size: 40,
              ),
              // Text('Raman Deep',
              //     style: GoogleFonts.notoSansDevanagari(
              //         fontSize: 16, fontWeight: FontWeight.bold)
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callApiaddtocart(String courseId) async {
    AddToCart response;
    Map<String, dynamic> body = {
      "batch_id": courseId,
    };
    try {
      setState(() {
        Preferences.onLoading(context);
      });
      var token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
      Response response = await dioAuthorizationData().post(
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
