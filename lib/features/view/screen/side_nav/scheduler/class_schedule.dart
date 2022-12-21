import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc_web/features/controller/scheduler_controller.dart';
import 'package:upsc_web/features/model/scheduler_model/class_scheduler.dart';
import 'package:upsc_web/utils/color_resources.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({Key? key}) : super(key: key);

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  SchedulerController schedulerController = SchedulerController();
  late Future<ClassSchedulerModel>getClassScheduleData;
  @override
  void initState() {
    getClassScheduleData = schedulerController.getClassScheduler();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClassSchedulerModel>(
        future: getClassScheduleData,
        builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.hasData){
          return _bodyWidget(context, snapshot.data!.data!);
        }else{
          return const Text('Something went wrong');
        }
      }else{
        return Center(child: CircularProgressIndicator());
      }
    });
  }
  Widget _bodyWidget(
      BuildContext context, List<ClassSchedulerDataModel> schedulerList) {
    return schedulerList.isNotEmpty
        ? ListView.builder(
      itemCount: schedulerList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => schedularContainerWidget(
          context: context, schedulerData: schedulerList[index]),
    )
        : const Center(
      child: Text('There is no Scheduler'),
    );
  }

  Widget schedularContainerWidget(
      {required BuildContext context,
        required ClassSchedulerDataModel schedulerData}) {
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
