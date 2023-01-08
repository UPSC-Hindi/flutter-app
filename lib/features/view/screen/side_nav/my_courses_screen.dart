import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/course_controller.dart';
import 'package:upsc_web/features/model/courses_model/MyCoursesModel.dart';
import 'package:upsc_web/features/view/widget/empty_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';

import 'course_view_screen.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {

  CoursesController coursesController = CoursesController();
  late Future<MyCoursesModel> getMyCourses;

  @override
  void initState() {
    getMyCourses = coursesController.getMyCourses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'My Courses',
          style:
          GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: FutureBuilder<MyCoursesModel>(
        future: getMyCourses,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              {
                if (snapshot.data!.data.isEmpty) {
                  return EmptyWidget(
                    text: 'There are no courses',
                    image: SvgImages.emptyCard,
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _myCoursesCardWidget(
                        context,
                        snapshot.data!.data[index],
                      ),
                    ),
                  );
                }
              }
            }else{
              return const Center(
                child: Text('Pls Refresh (or) Reopen App'),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Center _myCoursesCardWidget(
      BuildContext context, MyCoursesDataModel courseData) {
    print("courses status");
    print(courseData.batchDetails.isActive);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseData.batchDetails.batchName,
                style:  GoogleFonts.notoSansDevanagari(fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expires in ${courseData.batchDetails.endingDate.difference(DateTime.now()).inDays} Days',
                    style: GoogleFonts.notoSansDevanagari(
                        color: ColorResources.gray),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorResources.textblack.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if(courseData.batchDetails.isActive){
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => CourseViewScreen(
                              lecture: courseData.lectureDetails,
                              batch: courseData.batchDetails,
                            ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(courseData.batchDetails.isActive?'Continue':'Expired'), // <-- Text
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
