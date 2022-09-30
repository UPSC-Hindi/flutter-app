import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/models/course_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/bloc/courses/courses_bloc.dart';
import 'package:upsc/view/screens/bottomnav/coursesdetails.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: ColorResources.buttoncolor,
                  labelColor: ColorResources.buttoncolor,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Prelims"),
                    Tab(text: "Mains"),
                    Tab(text: "Interview"),
                    Tab(text: "RO"),
                  ]),
            ),
            Expanded(
              child: TabBarView(children: [
                const TabCoursesWidget(
                  type: 'Prelims',
                ),
                const TabCoursesWidget(
                  type: 'Mains',
                ),
                SingleChildScrollView(
                  child: Column(children: const [
                    Text('Mock Interview     '),
                    SizedBox(height: 300),
                    Text('Script')
                  ]),
                ),
                const Center(
                  child: Text("ro"),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class TabCoursesWidget extends StatefulWidget {
  const TabCoursesWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  final String type;

  @override
  State<TabCoursesWidget> createState() => _TabCoursesWidgetState();
}

class _TabCoursesWidgetState extends State<TabCoursesWidget> {
  @override
  initState() {
    context.read<CoursesBloc>().add(
          GetCourses(filter: widget.type, type: 'Category'),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesLoading) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (state is CoursesSuccess) {
          return _bodyWidget(state.courseList);
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }

  SingleChildScrollView _bodyWidget(List<CourseModel> courseData) {
    return SingleChildScrollView(
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: courseData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _cardWidget(courseData[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _cardWidget(CourseModel data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorResources.textWhite,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            data.batchName,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(Icons.sensors_outlined,color: ColorResources.buttoncolor,),
                  Text(
                    'Live lectures',
                    style: GoogleFonts.poppins(fontSize: 8),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.signal_cellular_alt),
                  Text(
                    '100% Online',
                    style: GoogleFonts.poppins(fontSize: 8),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.download),
                  Text(
                    'Downloadable',
                    style: GoogleFonts.poppins(fontSize: 8),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                data.charges,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: ColorResources.greenshad),
                child: Text(
                  'Aid Available',
                  style: GoogleFonts.poppins(
                      fontSize: 8, color: ColorResources.textWhite),
                ),
              )
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ColorResources.buttoncolor,
                shape: const StadiumBorder()),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CoursesBloc(),
                    child: CoursesDetailsScreens(
                      id: data.id,
                      buycourses: true,
                      coursename: "Saurabh",
                    ),
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Learn more'),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: const Color(0xFfD9D9D9).withOpacity(0.38),
                      borderRadius: BorderRadius.circular(90)),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
