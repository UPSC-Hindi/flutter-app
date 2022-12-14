import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc/features/data/remote/data_sources/scheduler_data_source/scheduler_remote_data_source_impl.dart';
import 'package:upsc/features/data/remote/models/my_scheduler_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/sidenav/class_schedule.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  String? datetoshow;
  final _dateController = TextEditingController();

  @override
  void initState() {
    context.read<ApiBloc>().add(
          GetMyScheduler(),
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
        title: Text(Languages.mySchedule,
            style: GoogleFonts.notoSansDevanagari(
                color: ColorResources.textblack)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            datetoshow == DateFormat('dd-MMMM-yyyy').format(DateTime.now())
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
                  onPressed: () {},
                  child: Text(
                    Languages.mySchedule,
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
                  )),
              TextButton(
                  onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClassSchedule(),
                        ),
                      ),
                  child: Text(
                    Languages.ClassSchedule,
                    style: GoogleFonts.notoSansDevanagari(
                        color: ColorResources.textblack),
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
          BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is ApiError) {
                return const Center(
                  child: Text('Pls Refresh (or) Reopen App'),
                );
              }
              if (state is ApiGetSchedulerSuccess) {
                return state.schedulerList.isEmpty
                    ? Center(
                        child: Text(Languages.noscheduler),
                      )
                    : _bodyWidget(context, state.schedulerList);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('MyScheduleAdd').then((value) {
            context.read<ApiBloc>().add(
                  GetMyScheduler(),
                );
          });
        },
        backgroundColor: ColorResources.buttoncolor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bodyWidget(
      BuildContext context, List<MySchedulerDataModel> schedulerList) {
    //flutterToast("loggedIn:${schedulerList[0].loggedIn}");
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
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
    );
  }

  Widget schedularContainerWidget(
      {required BuildContext context,
      required MySchedulerDataModel schedulerData}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(schedulerData.notifyAt),
                  Text(
                    schedulerData.task,
                    style: GoogleFonts.notoSansDevanagari(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      updatetask(schedulerData);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: ColorResources.edit,
                    )),
                IconButton(
                    onPressed: () {
                      Preferences.onLoading(context);
                      _deleteScheduler(schedulerData.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: ColorResources.delete,
                    ))
              ],
            )
          ],
        ),
        const Divider(),
      ],
    );
  }

  Future<void> updatetask(MySchedulerDataModel scheduler) async {
    var hours = [
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12"
    ];
    var min = [
      "00",
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "31",
      "32",
      "33",
      "34",
      "35",
      "36",
      "37",
      "38",
      "39",
      "40",
      "41",
      "42",
      "43",
      "44",
      "45",
      "46",
      "47",
      "48",
      "49",
      "50",
      "51",
      "52",
      "53",
      "54",
      "55",
      "56",
      "57",
      "58",
      "59",
      "60"
    ];
    var AMPM = [
      "AM",
      "PM",
    ];
    var _selectedhour;

    var _selectedmin;

    var _selectedAMPM = 'AM';
    String task = "";
    String date = "";
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Schdeule details',
                      style: GoogleFonts.notoSansDevanagari()),
                  TextField(
                    onChanged: (value) {
                      task = value.toString();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: ColorResources.gray, width: 1.0),
                      ),
                      hintText: 'Task',
                    ),
                  ),
                  TextField(
                    controller: _dateController,
                    onChanged: (value) {
                      date = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: ColorResources.gray, width: 1.0),
                      ),
                      hintText: 'Date',
                    ),
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2025),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          date = DateFormat('dd-MM-yyyy').format(selectedDate);
                          setState(() {
                            _dateController.text =
                                DateFormat('dd-MM-yyyy').format(selectedDate);
                          });
                        }
                      });
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorResources.gray)),
                    padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      const Text('Notify at'),
                      Row(
                        children: [
                          DropdownButton(
                            hint: const Text('HH'),
                            value: _selectedhour,
                            items: hours.map((String hours) {
                              return DropdownMenuItem(
                                value: hours,
                                child: Text(hours),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedhour = newValue;
                                print(newValue);
                              });
                            },
                          ),
                          Text(
                            ':   ',
                            style: GoogleFonts.notoSansDevanagari(
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                            hint: const Text("MM"),
                            value: _selectedmin,
                            items: min.map((String hours) {
                              return DropdownMenuItem(
                                value: hours,
                                child: Text(hours),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedmin = newValue;
                                print(newValue);
                              });
                            },
                          ),
                          DropdownButton(
                            hint: const Text("AM"),
                            value: _selectedAMPM,
                            items: AMPM.map((String hours) {
                              return DropdownMenuItem(
                                value: hours,
                                child: Text(hours),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedAMPM = newValue.toString();
                              });
                            },
                          ),
                        ],
                      )
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          String notifyAt = _selectedhour +
                              ":" +
                              _selectedmin +
                              " " +
                              _selectedAMPM;
                          if (task.isNotEmpty || date.isNotEmpty) {
                            _updateTask(scheduler.id, task, date, notifyAt);
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('Update')),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  _deleteScheduler(String schedulerId) async {
    final schedulerRemoteDataSourceImpl = SchedulerRemoteDataSourceImpl();
    Response response =
        await schedulerRemoteDataSourceImpl.deleteScheduler(schedulerId);
    if (response.statusCode == 200) {
      flutterToast(response.data['msg']);
      context.read<ApiBloc>().add(GetMyScheduler());
    } else {
      flutterToast(response.data['msg']);
    }
    Preferences.hideDialog(context);
  }

  void _updateTask(String id, String task, String date, String notifyAt) async {
    Preferences.onLoading(context);
    SchedulerRemoteDataSourceImpl schedulerRemoteDataSourceImpl =
        SchedulerRemoteDataSourceImpl();
    Response response = await schedulerRemoteDataSourceImpl
        .updateScheduler(id, task, notifyAt, isActive: true);
    flutterToast(response.data["msg"]);
    if (response.statusCode == 200) {
      context.read<ApiBloc>().add(GetMyScheduler());
    }
    Preferences.hideDialog(context);
  }
}
