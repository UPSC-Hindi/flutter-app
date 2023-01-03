

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/controller/scheduler_controller.dart';
import 'package:upsc_web/features/model/scheduler_model/my_scheduler_model.dart';
import 'package:upsc_web/utils/color_resources.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {

  SchedulerController schedulerController = SchedulerController();
  late Future<MySchedulerModel>getMyScheduleData;
  @override
  void initState() {
    getMyScheduleData = schedulerController.getMyScheduler();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MySchedulerModel>(
        future: getMyScheduleData,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              return snapshot.data!.data.isEmpty?Text('There is no scheduler'):_bodyWidget(context, snapshot.data!.data);
            }else{
              return const Text('Something went wrong');
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _bodyWidget(
      BuildContext context, List<MySchedulerDataModel> schedulerList) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          ListView.builder(
            itemCount: schedulerList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => schedulerContainerWidget(
                context: context, schedulerData: schedulerList[index]),
          ),
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }

  Widget schedulerContainerWidget(
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
                      // updatetask(schedulerData);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: ColorResources.edit,
                    )),
                IconButton(
                    onPressed: () {
                      // _deleteScheduler(schedulerData.id);
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
}
