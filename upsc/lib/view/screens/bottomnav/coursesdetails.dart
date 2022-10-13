import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/models/CoursesModel.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/models/AddToCart.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

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
    context.read<ApiBloc>().add(GetCourses(value: widget.id, key: 'id'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (context, state) {
        if (state is ApiCoursesSuccess) {
          return _bodyWidget(context, state.courseList[0]);
        }
        if (state is ApiError) {
          return const Scaffold(
            body: Center(child: Text('Something Went Wrong')),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Scaffold _bodyWidget(BuildContext context, CoursesDataModel course) {
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
                            Text(' Starts : ${DateFormat("dd-MM-yyyy").format(course.startingDate)}')
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
                    Container(
                      height: 110,
                      child: ListView.builder(
                        itemCount: course.student.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: [
                              Image.network(
                                'https://storage-upschindi.s3.ap-south-1.amazonaws.com/data/images/avatar.png',
                                height: 80,
                              ),
                              Text(
                                'Saurabh',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
                                  Text('Raman Deep',
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
                              callApiaddtocart(course);
                              Navigator.of(context)
                                  .popAndPushNamed('cartscreen');
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

  Future<BaseModel<AddToCart>> callApiaddtocart(CoursesDataModel course) async {
    AddToCart response;
    Map<String, dynamic> body = {
      "batch_id": widget.id,
    };
    try {
      var token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
      response =
          await RestClient(RetroApi().dioData(token)).addtocartRequest(body);
      if (response.status!) {
        Navigator.of(context).popAndPushNamed('cartscreen');
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${response.msg}',
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
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}