// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:upsc/features/presentation/bloc/api_bloc/api_bloc.dart';
// import 'package:upsc/models/classschedule.dart';
// import 'package:upsc/util/color_resources.dart';
// import 'package:upsc/util/langauge.dart';
// import 'package:upsc/view/screens/sidenav/myschedule.dart';
//
// class ClassSchedule extends StatefulWidget {
//   const ClassSchedule({Key? key}) : super(key: key);
//
//   @override
//   State<ClassSchedule> createState() => _ClassScheduleState();
// }
//
// class _ClassScheduleState extends State<ClassSchedule> {
//   String datetoshow = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   List listdata = [];
//   final _dateController = TextEditingController();
//
//   @override
//   void initState() {
//     context.read<ApiBloc>().add(
//           GetmyClassSchedule(),
//         );
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorResources.textWhite,
//         iconTheme: IconThemeData(color: ColorResources.textblack),
//         title: Text(
//           Languages.ClassSchedule,
//           style:
//               GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             datetoshow == DateFormat('dd-MM-yyyy').format(DateTime.now())
//                 ? Languages.scheduleForToday
//                 : "Schedule for",
//             style: GoogleFonts.notoSansDevanagari(fontSize: 20),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                   onPressed: () => Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder:
//                               (context, animation, secondaryAnimation) =>
//                                   const MySchedule(),
//                           transitionsBuilder:
//                               (context, animation, secondaryAnimation, child) {
//                             animation = CurvedAnimation(
//                                 curve: Curves.fastOutSlowIn, parent: animation);
//                             return FadeTransition(
//                               opacity: animation,
//                               child: child,
//                             );
//                           },
//                         ),
//                       ),
//                   child: Text(
//                     Languages.mySchedule,
//                     style: GoogleFonts.notoSansDevanagari(
//                         color: ColorResources.textblack),
//                   )),
//               TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     Languages.ClassSchedule,
//                     style: GoogleFonts.notoSansDevanagari(
//                       shadows: [
//                         Shadow(
//                             color: ColorResources.buttoncolor,
//                             offset: const Offset(0, -10))
//                       ],
//                       color: Colors.transparent,
//                       decoration: TextDecoration.underline,
//                       decorationColor: ColorResources.buttoncolor,
//                       decorationThickness: 4,
//                     ),
//                   ))
//             ],
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 primary: ColorResources.textWhite,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20))),
//             onPressed: () async {
//               listdata.clear();
//               DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1950),
//                   lastDate: DateTime(2100));
//               if (pickedDate != null) {
//                 print(
//                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                 String formattedDate =
//                     DateFormat('dd-MM-yyyy').format(pickedDate);
//                 print(
//                     formattedDate); //formatted date output using intl package =>  2021-03-16
//                 setState(() {
//                   datetoshow =
//                       formattedDate; //set output date to TextField value.
//                 });
//               } else {}
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   DateFormat('dd-MMMM-yyyy')
//                       .format(DateFormat('dd-MM-yyyy').parse(datetoshow)),
//                   style: GoogleFonts.notoSansDevanagari(
//                       color: ColorResources.textblack),
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: ColorResources.textblack,
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           BlocBuilder<ApiBloc, ApiState>(
//             builder: (context, state) {
//               if (state is ApiError) {
//                 return const Center(
//                   child: Text('Pls Refresh (or) Reopen App'),
//                 );
//               }
//               if (state is ApiGetMyclassSchedulerSucces) {
//                 state.myclassschedulerList.sort(
//                         (a, b) => (a.startingDate!.compareTo(b.startingDate!)));
//                 state.myclassschedulerList.forEach((element) {
//                   if (DateFormat("dd-MM-yyyy")
//                       .parse(element.startingDate!)
//                       .toString()
//                       .split(" ")[0] ==
//                       DateFormat("dd-MM-yyyy")
//                           .parse(datetoshow)
//                           .toString()
//                           .split(" ")[0]) {
//                     listdata.add(element);
//                     print('------found u---------');
//                   }
//                 });
//                 return state.myclassschedulerList.isEmpty
//                     ? const Center(
//                         child: Text('There is no Scheduler'),
//                       )
//                     : _classSchedulerWidget(context, state.myclassschedulerList);
//               }
//
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
// }
