import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
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
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80,
              height: 25,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: ColorResources.gray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: PopupMenuButton(
                onSelected: (value) {
                  // your logic
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'IAS',
                      style: GoogleFonts.notoSansDevanagari(
                        color: ColorResources.textblack.withOpacity(0.9),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: ColorResources.textblack.withOpacity(0.5),
                    ),
                  ],
                ),
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      value: '/hello',
                      child: Text("IAS"),
                    ),
                    PopupMenuItem(
                      value: '/about',
                      child: Text("IPS"),
                    ),
                    PopupMenuItem(
                      value: '/contact',
                      child: Text("PCS"),
                    )
                  ];
                },
              ),
            ),
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
                  ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                TabCoursesWidget(
                  value: 'Prelims',
                ),
                TabCoursesWidget(
                  value: 'Mains',
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
    required this.value,
  }) : super(key: key);
  final String value;

  @override
  State<TabCoursesWidget> createState() => _TabCoursesWidgetState();
}

class _TabCoursesWidgetState extends State<TabCoursesWidget> {
  @override
  void initState() {
    context.read<ApiBloc>().add(
          GetCourses(key: 'Category', value: widget.value),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ApiError) {
          return const Center(
            child: Text('Pls Refresh (or) Reopen App'),
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

  SingleChildScrollView _bodyWidget(List<CoursesDataModel> courseData) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Courses',
                style: GoogleFonts.notoSansDevanagari(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: courseData.length,
                itemBuilder: (context, index) => _cardWidget(courseData[index]))
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
            data.batchName,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '₹${data.charges}',
                style: GoogleFonts.notoSansDevanagari(
                    color: ColorResources.textblack,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
              int.parse(data.discount) > 0
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: ColorResources.greenshad,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        ' ${data.discount} % discount',
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 12, color: ColorResources.textWhite),
                      ),
                    )
                  : Text('')
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ColorResources.buttoncolor,
                shape: const StadiumBorder()),
            onPressed: () {
              Navigator.popUntil(context, (route) => false);
              Navigator.pushNamed(context, 'home');
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CoursesDetailsScreens(
                    course: data,
                  ),
                ),
              );
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
