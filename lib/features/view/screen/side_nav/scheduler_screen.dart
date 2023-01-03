import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upsc_web/features/view/screen/side_nav/scheduler/class_schedule.dart';
import 'package:upsc_web/features/view/screen/side_nav/scheduler/my_scheduler.dart';
import 'package:upsc_web/utils/color_resources.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({Key? key}) : super(key: key);

  @override
  State<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Schedule For Today'),
          bottom: TabBar(
            indicatorColor: ColorResources.buttoncolor,
            labelColor: ColorResources.buttoncolor,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: "My Schedule"),
              Tab(text: "Class Schedule")
            ],
          ),),
        body: TabBarView(children: [
          MySchedule(),
          ClassSchedule(),
        ]),
      ),
    );
  }
}
