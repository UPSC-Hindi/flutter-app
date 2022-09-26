import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/color_resources.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  String? datetoshow;
  @override
  void initState() {
    super.initState();
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text('My Schedule',
            style: GoogleFonts.poppins(color: ColorResources.textblack)),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            datetoshow == DateFormat('dd-MMMM-yyyy').format(DateTime.now())
                ? 'Schedule for Today'
                : "Schedule for",
            style: GoogleFonts.poppins(fontSize: 20),
          ),
          SizedBox(
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
                  style: GoogleFonts.poppins(color: ColorResources.textblack),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: ColorResources.textblack,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FractionallySizedBox(
            widthFactor: 0.90,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorResources.gray),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
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
                              Text("11:15 AM "),
                              Text(
                                "Revise Sample Notes",
                                style: GoogleFonts.poppins(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updatetask(context);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorResources.edit,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorResources.delete,
                                ))
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("11:15 AM "),
                              Text(
                                "Revise Sample Notes",
                                style: GoogleFonts.poppins(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updatetask(context);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorResources.edit,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorResources.delete,
                                ))
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("11:15 AM "),
                              Text(
                                "Revise Sample Notes",
                                style: GoogleFonts.poppins(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updatetask(context);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorResources.edit,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorResources.delete,
                                ))
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("11:15 AM "),
                              Text(
                                "Revise Sample Notes",
                                style: GoogleFonts.poppins(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  updatetask(context);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorResources.edit,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorResources.delete,
                                ))
                          ],
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('MyScheduleAdd');
        },
        backgroundColor: ColorResources.buttoncolor,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> updatetask(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Schdeule details', style: GoogleFonts.poppins()),
                TextField(
                  //controller: TextEditingController()..text = 'pratik@xyz.com',
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: ColorResources.gray, width: 1.0),
                    ),
                    hintText: 'Date',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorResources.gray)),
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Text('Notify at'),
                    Row(
                      children: [],
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorResources.buttoncolor,
                          shape: const StadiumBorder()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Update')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
