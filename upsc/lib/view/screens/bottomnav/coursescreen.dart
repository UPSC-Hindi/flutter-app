import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/models/course_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
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
                  tabs: [
                    Tab(text: Languages.prelims),
                    Tab(text: Languages.mains),
                    Tab(text: Languages.interview),
                    Tab(text: Languages.ro),
                  ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                TabCoursesWidget(
                  filter: 'Prelims',
                ),
                TabCoursesWidget(
                  filter: 'Mains',
                ),
                Center(
                  child: Text("Update will come soon......"),
                ),
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
}

class TabCoursesWidget extends StatefulWidget {
  const TabCoursesWidget({
    Key? key,
    required this.filter,
  }) : super(key: key);
  final String filter;

  @override
  State<TabCoursesWidget> createState() => _TabCoursesWidgetState();
}

class _TabCoursesWidgetState extends State<TabCoursesWidget> {
  @override
  initState() {
    context.read<ApiBloc>().add(
          GetCourses(filter: widget.filter, type: 'Category'),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (context, state) {
        if (state is ApiError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        if (state is ApiCoursesSuccess) {
          return state.courseList.isEmpty
              ? const Center(
                  child: Text('There is no courses'),
                )
              : _bodyWidget(state.courseList);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  SingleChildScrollView _bodyWidget(List<CourseDataModel> courseData) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Courses',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: courseData.length,
                itemBuilder: (context, index) => _cardWidget(courseData[index]))
          ],
        ),
      ),
    );
  }

  Container _cardWidget(CourseDataModel data) {
    return Container(
      margin: EdgeInsets.all(20),
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
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '₹${data.charges}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: ColorResources.greenshad),
                child: Text(
                  'Aid Available',
                  style:
                      TextStyle(fontSize: 8, color: ColorResources.textWhite),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ColorResources.buttoncolor,
                shape: const StadiumBorder()),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CoursesDetailsScreens(
                    id: data.id,
                    buycourses: true,
                    coursename: data.batchName,
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
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
            ),
          )
        ],
      ),
    );
  }
}
