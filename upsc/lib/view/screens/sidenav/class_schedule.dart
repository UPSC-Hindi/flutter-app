import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/models/classschedule.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/sidenav/myschedule.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({Key? key}) : super(key: key);

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  String datetoshow = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List listdata = [];
  final _dateController = TextEditingController();

  @override
  void initState() {
    context.read<ApiBloc>().add(
          GetmyClassSchedule(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          "Class Schedule",
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Pls Refresh (or) Reopen App'),
            );
          }
          if (state is ApiGetMyclassSchedulerSucces) {
            state.myclassschedulerList
                .sort((a, b) => (a.startingDate!.compareTo(b.startingDate!)));
            state.myclassschedulerList.forEach((element) {
              if (DateFormat("dd-MM-yyyy")
                      .parse(element.startingDate!)
                      .toString()
                      .split(" ")[0] ==
                  DateFormat("dd-MM-yyyy")
                      .parse(datetoshow)
                      .toString()
                      .split(" ")[0]) {
                listdata.add(element);
                print('------found u---------');
              }
            });
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
                datetoshow == DateFormat('dd-MM-yyyy').format(DateTime.now())
                    ? Languages.scheduleForToday
                    : "Schedule for",
                style: GoogleFonts.notoSansDevanagari(fontSize: 20),
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
                        style: GoogleFonts.notoSansDevanagari(
                            color: ColorResources.textblack),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Class Schedule',
                        style: GoogleFonts.notoSansDevanagari(
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
                  listdata.clear();
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
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
                      DateFormat('dd-MMMM-yyyy')
                          .format(DateFormat('dd-MM-yyyy').parse(datetoshow)),
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.textblack),
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
              listdata.isNotEmpty
                  ? ListView.builder(
                      itemCount: listdata.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => schedularContainerWidget(
                          context: context, schedulerData: listdata[index]),
                    )
                  : const Center(
                      child: Text('There is no Scheduler'),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.gray.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        color: ColorResources.textWhite.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Text(
                  schedulerData.lectureTitle!,
                  style: GoogleFonts.notoSansDevanagari(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //Text(schedulerData.startingDate!),
              Text(DateFormat.jm()
                  .format(DateFormat('dd-MM-yyyy HH:mm:ss')
                      .parse(schedulerData.startingDate!))
                  .toString()),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Text(
                  schedulerData.description!,
                  maxLines: 1,
                  style: GoogleFonts.notoSansDevanagari(fontSize: 14),
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
                  child: const Text("go")),
            ],
          ),
        ],
      ),
    );
  }
}
