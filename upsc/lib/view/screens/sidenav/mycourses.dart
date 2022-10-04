import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/screens/bottomnav/coursesdetails.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          iconTheme: IconThemeData(color: ColorResources.textblack),
          title: Text(
            'My Courses',
            style: TextStyle(color: ColorResources.textblack),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'In Progress',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 120,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Course 1',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            '45% Complete',
                            style: TextStyle(color: ColorResources.gray),
                          )
                        ],
                      ),
                      LinearProgressIndicator(
                        value: 0.45,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorResources.buttoncolor),
                        backgroundColor: ColorResources.gray.withOpacity(0.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Expires in 2 months',
                            style: TextStyle(color: ColorResources.gray),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  ColorResources.textblack.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              //  remove when this page dynamic*******************************
                              Navigator.of(context).pushNamed('courseviewscreen');
                              // pls un comment this page dynamic************************************
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => CoursesDetailsScreens(
                              //       buycourses: false,
                              //       coursename: 'courses 1', id: '',
                              //     ),
                              //   ),
                              // );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Continue'), // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
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
            ),
          ],
        ),);
  }
}
