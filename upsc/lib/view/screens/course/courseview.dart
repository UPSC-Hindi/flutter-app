import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseViewScreen extends StatelessWidget {
  const CourseViewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CourseViewScreen'),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: ColorResources.buttoncolor,
                  labelColor: ColorResources.buttoncolor,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Videos"),
                    Tab(text: "Tests"),
                    Tab(text: "Notes"),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Lecture 1',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ]),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Courses',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Courses',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorResources.buttoncolor,
          onPressed: () async{
            await [Permission.camera, Permission.microphone].request();
            Navigator.of(context).pushNamed('joinstreaming');
          },
          child: Center(
            child: Column(
              children: [Icon(Icons.sensors_outlined), Text('live')],
            ),
          ),
        ));
  }
}
