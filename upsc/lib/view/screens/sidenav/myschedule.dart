import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upsc/features/data/remote/models/my_scheduler_model.dart';
import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';

class MySchedule extends StatefulWidget {
  const MySchedule({Key? key}) : super(key: key);

  @override
  State<MySchedule> createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  String? datetoshow;

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
            style: GoogleFonts.poppins(color: ColorResources.textblack)),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ApiError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (state is ApiGetSchedulerSuccess) {
            return state.schedulerList.isEmpty
                ? const Center(
              child: Text('There is no Scheduler'),
            ):
                _bodyWidget(context,state.schedulerList);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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

  Container _bodyWidget(BuildContext context,List<MySchedulerDataModel> schedulerList){
    return Container(
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
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: schedulerList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => schedularContainerWidget(context: context,schedulerData: schedulerList[index]),
        ),
      ]),
    );
  }

  Container schedularContainerWidget({required BuildContext context,required MySchedulerDataModel schedulerData}) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorResources.borderColor),
      ),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Row(
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
    );
  }

  Future<void> updatetask(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
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
                    const Text('Notify at'),
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
                      child: const Text('Update')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}