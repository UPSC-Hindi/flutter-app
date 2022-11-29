import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/features/data/remote/models/video_model.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/bottomnav/ncert.dart';
import 'package:upsc/view/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({
    Key? key,
  }) : super(key: key);
  // final VoidCallback onTap;

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<Widget> images = [];
  RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();

  Future<BaseModel<getbannerdetails>> callApigetbanner() async {
    getbannerdetails response;
    try {
      response = await RestClient(RetroApi2().dioData2()).bannerimagesRequest();
      print(response.msg);
      for (var entry in response.data!) {
        for (String image in entry.bannerUrl!) {
          images.add(
            Image.network(image),
          );
        }
      }
      setState(() {});
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  late Future<MyCoursesModel> myCoursesData;

  @override
  void initState() {
    callApigetbanner();
    myCoursesData = remoteDataSourceImpl.getMyCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 5)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: CarouselSlider(
                  items: images,
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
              Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 10, top: 10, bottom: 10),
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
                          style: TextStyle(
                              fontSize: 13,
                              color: ColorResources.textblack,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'dailynews');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Explore',
                                  style: GoogleFonts.poppins(
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
                                    size: 8,
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
                          SvgImages.currentaffer2,
                          height: MediaQuery.of(context).size.height * 0.021,
                        ),
                        Image.network(
                          SvgImages.currentaffer1,
                          height: MediaQuery.of(context).size.height * 0.021,
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
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: ColorResources.textblack),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                height: 138,
                child: FutureBuilder<MyCoursesModel>(
                    future: myCoursesData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          MyCoursesModel? myCourses = snapshot.data;
                          return myCourses!.data.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 20, top: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorResources.textWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.gray
                                            .withOpacity(0.5),
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Do Explore all the courses',
                                        style: TextStyle(
                                            color: ColorResources.gray,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(
                                              index: 1,
                                            ),
                                          ));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: ColorResources.buttoncolor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Continue',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                ),
                                              ), // <-- Text
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: ColorResources.gray
                                                      .withOpacity(0.3),
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
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: myCourses.data.length,
                                  itemBuilder: (context, index) =>
                                      _myCoursesCardWidget(
                                    myCourses.data[index],
                                  ),
                                );
                        } else {
                          return const Text("There is no internet Connection");
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Languages.latestNews,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NcertScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' Explore ',
                              style: GoogleFonts.poppins(
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
                child: FutureBuilder<VideoModel>(
                  future: remoteDataSourceImpl.getYouTubeVideo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<VideoDataModel> videoList = snapshot.data!.data;
                        return videoList.isEmpty
                            ? const Text("No Video")
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: videoList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 130,
                                  height: 90,
                                  child: YouTubeContainerWidget(
                                    videoUrl: videoList[index].videoUrl,
                                    height: 90,
                                  ),
                                ),
                              );
                      } else {
                        return const Text("No Video");
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 15),
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
                              CachedNetworkImage(
                                imageUrl: SvgImages.youtube,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
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
                            CachedNetworkImage(
                              imageUrl: SvgImages.telegram,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
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
      ),
    );
  }

  Container _myCoursesCardWidget(MyCoursesDataModel data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorResources.textWhite,
        boxShadow: [
          BoxShadow(
            color: ColorResources.gray.withOpacity(0.5),
            blurRadius: 5.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.batchDetails.batchName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0Xff444444)),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.sensors_outlined,
                    color: Colors.redAccent,
                  ),
                  Text(
                    'Live lectures',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.signal_cellular_alt),
                  Text(
                    '100% Online',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.download),
                  Text(
                    'Downloadable',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'mycoursesscreen');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ColorResources.buttoncolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
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
    );
  }
}
