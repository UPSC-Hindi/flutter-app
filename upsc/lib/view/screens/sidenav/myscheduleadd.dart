import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';

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

  var _selectedAMPM;

  var _iseveryday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          iconTheme: IconThemeData(color: ColorResources.textblack),
          title: Text('My Schedule',
              style: GoogleFonts.poppins(color: ColorResources.textblack))),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Date',
              style: GoogleFonts.poppins(
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
                  weekendTextStyle: const TextStyle(color: Colors.red),
                  selectedDecoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  selectedTextStyle: TextStyle(color: ColorResources.textWhite),
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
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: addtaskcount,
            itemBuilder: (context, index) {
              return Padding(
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
                        'Schdeule details',
                        style: GoogleFonts.poppins(),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorResources.gray, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.gray, width: 1.0),
                          ),
                          hintText: 'Task',
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
                              'Notify at',
                              style: GoogleFonts.poppins(),
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
                                  style: GoogleFonts.poppins(
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
                                      _selectedAMPM = newValue;
                                      print(newValue);
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
                                print(value);
                              });
                            }),
                        const Text('Schedule for everyday')
                      ]),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                addtaskcount = addtaskcount + 1;
                              });
                            },
                            child: Text(
                              '+Add Task',
                              style: GoogleFonts.poppins(
                                color: ColorResources.buttoncolor,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: ColorResources.buttoncolor,
                  shape: const StadiumBorder()),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Create for ' +
                  DateFormat('MMMM dd').format(selectDate).toString()),
            ),
          ),
        ]),
      ),
    );
  }
}
