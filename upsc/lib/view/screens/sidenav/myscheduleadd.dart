import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:upsc/features/data/remote/data_sources/scheduler_data_source/scheduler_remote_data_source_impl.dart';
import 'package:upsc/features/domain/reused_function.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';

class MyScheduleAdd extends StatefulWidget {
  const MyScheduleAdd({Key? key}) : super(key: key);

  @override
  State<MyScheduleAdd> createState() => _MyScheduleAddState();
}

class _MyScheduleAddState extends State<MyScheduleAdd> {
  DateTime selectDate = DateTime.now();
  DateTime focuseDate = DateTime.now();
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
  int addtaskcount = 1;

  var _selectedhour;

  var _selectedmin;

  var _selectedAMPM = 'AM';

  var _iseveryday = false;

  String task = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          iconTheme: IconThemeData(color: ColorResources.textblack),
          title: Text(Languages.mySchedule,
              style: GoogleFonts.notoSansDevanagari(
                  color: ColorResources.textblack))),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Languages.selectDate,
              style: GoogleFonts.notoSansDevanagari(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(1954, 10, 16),
                lastDay: DateTime.utc(2159, 10, 16),
                calendarStyle: CalendarStyle(
                  weekendTextStyle:  GoogleFonts.notoSansDevanagari(color: Colors.red),
                  selectedDecoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  selectedTextStyle: GoogleFonts.notoSansDevanagari(color: ColorResources.textWhite),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(selectDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectDate = selectedDay;
                    focuseDate =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    Languages.scheduleDetails,
                    style: GoogleFonts.notoSansDevanagari(),
                  ),
                  TextField(
                    onChanged: (value) {
                      task = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: ColorResources.gray, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorResources.gray, width: 1.0),
                      ),
                      hintText: Languages.task,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: ColorResources.gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.notifyAt,
                          style: GoogleFonts.notoSansDevanagari(),
                        ),
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
                      ],
                    ),
                  ),
                  Row(children: [
                    Switch(
                        value: _iseveryday,
                        onChanged: (value) {
                          setState(() {
                            _iseveryday = value;
                          });
                        }),
                    Text(Languages.scheduleForEveryday)
                  ]),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           addtaskcount = addtaskcount + 1;
                  //         });
                  //       },
                  //       child: Text(
                  //         Languages.addTask,
                  //         style: GoogleFonts.notoSansDevanagari(
                  //           color: ColorResources.buttoncolor,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )),
                  // )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorResources.buttoncolor,
                  shape: const StadiumBorder()),
              onPressed: () {
                if (task.isNotEmpty &&
                    _selectedhour != null &&
                    _selectedmin != null) {
                  _addSchedular(task,
                      _selectedhour + ":" + _selectedmin + " " + _selectedAMPM);
                } else {
                  flutterToast('Select All the fields');
                }
              },
              child: Text(
                  '${Languages.createdFor} ${DateFormat('MMMM dd').format(selectDate)}'),
            ),
          ),
        ]),
      ),
    );
  }

  void _addSchedular(String task, String time) async {
    final schedulerRemoteDataSourceImpl = SchedulerRemoteDataSourceImpl();
    try {
      Preferences.onLoading(context);
      Response response =
          await schedulerRemoteDataSourceImpl.addSchedule(task, time);
      if (response.statusCode == 200) {
        Preferences.hideDialog(context);
        if (response.data['status']) {
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, 'MySchedule');
          flutterToast(response.data['msg']);
        } else {
          loginRoute();
        }
      } else {
        Preferences.hideDialog(context);
        flutterToast(response.data['msg']);
      }
    } catch (error) {
      print(error);
      flutterToast('Server Error');
    }
  }
}
