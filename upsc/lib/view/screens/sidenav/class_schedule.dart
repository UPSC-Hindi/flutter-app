import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc/features/data/remote/data_sources/scheduler_data_source/scheduler_remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/my_scheduler_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/classschedule.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/sidenav/myschedule.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({Key? key}) : super(key: key);

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  String? datetoshow;
  final _dateController = TextEditingController();

  @override
  void initState() {
    context.read<ApiBloc>().add(
          GetmyClassSchedule(),
        );
    super.initState();
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          "Class Schedule",
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (state is ApiGetMyclassSchedulerSucces) {
            return state.myclassschedulerList.isEmpty
                ? const Center(
                    child: Text('There is no Scheduler'),
                  )
                : _bodyWidget(context, state.myclassschedulerList);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _bodyWidget(
      BuildContext context, List<classScheduleModel> schedulerList) {
    //flutterToast("loggedIn:${schedulerList[0].loggedIn}");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                datetoshow == DateFormat('dd-MMMM-yyyy').format(DateTime.now())
                    ? Languages.scheduleForToday
                    : "Schedule for",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const MySchedule(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                animation = CurvedAnimation(
                                    curve: Curves.fastOutSlowIn,
                                    parent: animation);
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          ),
                      child: Text(
                        'My Schedule',
                        style: GoogleFonts.poppins(
                            color: ColorResources.textblack),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Class Schedule',
                        style: GoogleFonts.poppins(
                          shadows: [
                            Shadow(
                                color: ColorResources.buttoncolor,
                                offset: const Offset(0, -10))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorResources.buttoncolor,
                          decorationThickness: 4,
                        ),
                      ))
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: ColorResources.textWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MMMM-yyyy').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      datetoshow =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$datetoshow',
                      style:
                          GoogleFonts.poppins(color: ColorResources.textblack),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: ColorResources.textblack,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: schedulerList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => schedularContainerWidget(
                    context: context, schedulerData: schedulerList[index]),
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget schedularContainerWidget(
      {required BuildContext context,
      required classScheduleModel schedulerData}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              child: Text(
                schedulerData.lectureTitle!,
                style: GoogleFonts.poppins(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(schedulerData.startingDate!),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              child: Text(
                schedulerData.description!,
                maxLines: 1,
                style: GoogleFonts.poppins(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('mycoursesscreen');
                },
                style: ElevatedButton.styleFrom(
                    primary: ColorResources.buttoncolor,
                    shape: const StadiumBorder()),
                child: Text("go")),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
