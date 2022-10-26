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
      body: BlocBuilder<ApiBloc, ApiState>(
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
                  )
                : _bodyWidget(context, state.schedulerList);
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

  Widget _bodyWidget(
      BuildContext context, List<MySchedulerDataModel> schedulerList) {
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
                      style:
                          GoogleFonts.poppins(color: ColorResources.textblack),
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
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => schedularContainerWidget(
                    context: context, schedulerData: schedulerList[index]),
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
        Divider(),
      ],
    );
  }

  Future<void> updatetask(MySchedulerDataModel scheduler) async {
    String task = "";
    String date = "";
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
                  onChanged: (value){
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
                  onChanged: (value){
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
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorResources.gray)),
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    const Text('Notify at'),
                    Row(
                      children: const [],
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
                        String notifyAt = "";
                        if(task.isNotEmpty||date.isNotEmpty){
                          _updateTask(scheduler.id,task,date,notifyAt);
                        }
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

  void _updateTask(String id,String task,String date,String notifyAt) async{
    Preferences.onLoading(context);
    SchedulerRemoteDataSourceImpl schedulerRemoteDataSourceImpl = SchedulerRemoteDataSourceImpl();
    Response response = await schedulerRemoteDataSourceImpl.updateScheduler(id,task,notifyAt,isActive: true);
    flutterToast(response.data["msg"]);
    if(response.statusCode==200){
      context.read<ApiBloc>().add(GetMyScheduler());
    }
    Preferences.hideDialog(context);
  }
}
