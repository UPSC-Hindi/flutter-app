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
import 'package:upsc/view/screens/sidenav/class_schedule.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  String? datetoshow;
  final _dateController = TextEditingController();
  final schedulerRemoteDataSourceImpl = SchedulerRemoteDataSourceImpl();
  List listdata = [];
  late Future<MySchedulerModel> getMyScheduleData;
  late Future<ClassSchedulermodel> getClassScheduler;

  @override
  void initState() {
    getClassScheduler = schedulerRemoteDataSourceImpl.getMyClassSchedule();
    getMyScheduleData = schedulerRemoteDataSourceImpl.getSchedule();
    super.initState();
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            TabBar(
              indicatorColor: ColorResources.buttoncolor,
              labelColor: ColorResources.buttoncolor,
              unselectedLabelColor: Colors.black,
              tabs: [Tab(text: "My Schedule"), Tab(text: "Class Schedule")],
            ),
            const SizedBox(
              height: 10,
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
            Flexible(
              child: TabBarView(
                children: [
                  FutureBuilder<MySchedulerModel>(
                      future: getMyScheduleData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return snapshot.data!.data.isEmpty
                                ? Center(
                                    child: Text(Languages.noscheduler),
                                  )
                                : _mySchedulerWidget(
                                    context, snapshot.data!.data);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return const Center(
                              child: Text('Pls Refresh (or) Reopen App'),
                            );
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<ClassSchedulermodel>(
                    future: getClassScheduler,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          snapshot.data!.data!.sort((a, b) =>
                              (a.startingDate!.compareTo(b.startingDate!)));
                          snapshot.data!.data!.forEach((element) {
                            if (DateFormat("dd-MM-yyyy")
                                    .parse(element.startingDate!)
                                    .toString()
                                    .split(" ")[0] ==
                                DateFormat("dd-MM-yyyy")
                                    .parse(datetoshow!)
                                    .toString()
                                    .split(" ")[0]) {
                              listdata.add(element);
                              print('------found u---------');
                            }
                          });
                          return snapshot.data!.data!.isEmpty
                              ? Center(
                                  child: Text(Languages.noscheduler),
                                )
                              : _classSchedulerWidget(
                                  context, snapshot.data!.data!);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const Center(
                            child: Text('Pls Refresh (or) Reopen App'),
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('MyScheduleAdd').then((value) {
              setState(() {
                getMyScheduleData = schedulerRemoteDataSourceImpl.getSchedule();
              });
            });
          },
          backgroundColor: ColorResources.buttoncolor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _classSchedulerWidget(
      BuildContext context, List<classScheduleModel> schedulerList) {
    //flutterToast("loggedIn:${schedulerList[0].loggedIn}");
    return SingleChildScrollView(
      child: Column(
        children: [
          listdata.isNotEmpty
              ? ListView.builder(
                  itemCount: listdata.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      classSchedulerContainerWidget(
                          context: context, schedulerData: listdata[index]),
                )
              : const Center(
                  child: Text('There is no Scheduler'),
                ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget classSchedulerContainerWidget(
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

  Widget _mySchedulerWidget(
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
      setState(() {
        getMyScheduleData = schedulerRemoteDataSourceImpl.getSchedule();
      });
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
      setState(() {
        getMyScheduleData = schedulerRemoteDataSourceImpl.getSchedule();
      });
    }
    Preferences.hideDialog(context);
  }
}
