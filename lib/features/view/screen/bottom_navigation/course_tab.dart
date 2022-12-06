import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/course_controller.dart';
import 'package:upsc_web/features/model/courses_model/CoursesModel.dart';
import 'package:upsc_web/features/view/widget/empty_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  CoursesController coursesController = CoursesController();

  late Future<CoursesModel> getMainCourses;
  late Future<CoursesModel> getPrelimsCourses;

  @override
  void initState() {
    getMainCourses = coursesController.getCourses('Mains');
    getPrelimsCourses = coursesController.getCourses('Prelims');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                indicatorColor: ColorResources.buttoncolor,
                labelColor: ColorResources.buttoncolor,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Main',),
                  Tab(text: 'Prelims',),
                  // Tab(text: Languages.prelims),
                  // Tab(text: Languages.mains),
                  // Tab(text: Languages.interview)
                  Tab(text: "Interview",),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                FutureBuilder<CoursesModel>(
                    future: getMainCourses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.data.length,
                              itemBuilder: (context, index) {
                                return snapshot.data!.data.isEmpty
                                    ? EmptyWidget(
                                        image: SvgImages.emptyCard,
                                        text: "No Courses")
                                    : _cardWidget(snapshot.data!.data[index]);
                              });
                        } else {
                          return const Text("Unable to get data");
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                FutureBuilder<CoursesModel>(
                    future: getPrelimsCourses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                return snapshot.data!.data!.isEmpty
                                    ? EmptyWidget(
                                    image: SvgImages.emptyCard,
                                    text: "No Courses")
                                    : _cardWidget(snapshot.data!.data![index]);
                              });
                        } else {
                          return const Text("Unable to get data");
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                Center(
                  child: Text("Update will come soon......"),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Container _cardWidget(CoursesDataModel data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
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
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            data.batchName! ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.notoSansDevanagari(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: ColorResources.textblack),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.sensors_outlined,
                    color: Colors.redAccent,
                  ),
                  Text(
                    'Live lectures',
                    style: GoogleFonts.notoSansDevanagari(fontSize: 12),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.signal_cellular_alt),
                  Text(
                    '100% Online',
                    style: GoogleFonts.notoSansDevanagari(fontSize: 12),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.download),
                  Text(
                    'Downloadable',
                    style: GoogleFonts.notoSansDevanagari(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ColorResources.buttoncolor,
                shape: const StadiumBorder()),
            onPressed: () {
              // Navigator.popUntil(context, (route) => false);
              // Navigator.pushNamed(context, 'home');
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => CoursesDetailsScreens(courseId: data.id, courseName: data.batchName,
              //     ),
              //   ),
              // );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Learn more',
                    style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: ColorResources.textWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(90)),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}