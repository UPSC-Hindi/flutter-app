import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/models/course_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/view/bloc/courses/courses_bloc.dart';
import 'package:intl/intl.dart';

class CoursesDetailsScreens extends StatefulWidget {
  bool? buycourses;
  String? coursename;
  final String id;

  CoursesDetailsScreens(
      {Key? key, this.buycourses, this.coursename, required this.id})
      : super(key: key);

  @override
  State<CoursesDetailsScreens> createState() => _CoursesDetailsScreensState();
}

class _CoursesDetailsScreensState extends State<CoursesDetailsScreens> {
  bool? buycourse;
  String? coursename;

  @override
  void initState() {
    super.initState();
    setState(() {
      buycourse = widget.buycourses;
      coursename = widget.coursename;
    });
    context.read<CoursesBloc>().add(GetCourses(filter: widget.id, type: 'id'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesSuccess) {
          return _bodyWidget(context, state.courseList[0]);
        }
        if (state is CoursesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Something Went Wrong')),
        );
      },
    );
  }

  Scaffold _bodyWidget(BuildContext context, CourseModel course) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          coursename!,
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Course Details  ',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
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
                        Row(children: [
                          Icon(
                            Icons.play_circle_fill_outlined,
                          ),
                          Text('  75 Video Lectures')
                        ]),
                        Row(children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 20,
                          ),
                          Text('  25 Tests')
                        ]),
                        Row(children: [
                          Icon(
                            Icons.sensors_outlined,
                          ),
                          Text(' Live Access')
                        ]),
                        Row(children: [
                          Icon(
                            Icons.book,
                          ),
                          Text('45 Readings')
                        ]),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Duration  ',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
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
                            Icon(
                              Icons.access_time_rounded,
                            ),
                            Text(
                                '  ${course.endingDate.difference(course.startingDate).inDays} Days')
                          ]),
                          Row(children: [
                            Icon(
                              Icons.calendar_month_rounded,
                            ),
                            Text(
                                ' Starts : ${DateFormat("dd-MM-yyyy").format(course.startingDate)}')
                          ]),
                        ]),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Faculty  ',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 80,
                                ),
                                Text('Lorem Ipsum',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 80,
                                ),
                                Text('Lorem Ipsum',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 80,
                                ),
                                Text('Lorem Ipsum',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 80,
                                ),
                                Text('Lorem Ipsum',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_circle_rounded,
                                  size: 80,
                                ),
                                Text('Lorem Ipsum',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9),
                            borderRadius: BorderRadius.circular(90)),
                        child: Text(
                          '  Watch Demos  ',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
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
                                  Icon(
                                    Icons.account_circle_rounded,
                                    size: 80,
                                  ),
                                  Text('Lorem Ipsum',
                                      style: GoogleFonts.poppins(
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
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: 60,
              child: buycourse!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '₹${course.charges}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorResources.buttoncolor,
                                shape: const StadiumBorder()),
                            onPressed: () {
                              Navigator.of(context).pushNamed('cartscreen');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 5.0),
                              child: Text('Add to Cart',
                                  style: GoogleFonts.poppins(fontSize: 20)),
                            ))
                      ],
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.of(context).pushNamed('courseviewscreen');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 5.0),
                          child: Text('Go to Course',
                              style: GoogleFonts.poppins(fontSize: 20)),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
}
