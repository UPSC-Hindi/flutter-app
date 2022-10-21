import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/joinStreaming.dart';
import 'package:intl/intl.dart';

class CourseViewScreen extends StatefulWidget {
  const CourseViewScreen(
      {Key? key,
      required this.lecture,
      required this.batchTitle,
      required this.batchDesc,
      required this.startDate,
      required this.endDate})
      : super(key: key);
  final String batchTitle;
  final String batchDesc;
  final DateTime startDate;
  final DateTime endDate;
  final List<LectureDetail> lecture;

  @override
  State<CourseViewScreen> createState() => _CourseViewScreenState();
}

class _CourseViewScreenState extends State<CourseViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.batchTitle,
          style: TextStyle(
            color: ColorResources.textblack,
          ),
        ),
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(
          color: ColorResources.textblack,
        ),
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(children: <Widget>[
          Container(
            constraints: const BoxConstraints.expand(height: 50),
            child: TabBar(
              indicatorColor: ColorResources.buttoncolor,
              labelColor: ColorResources.buttoncolor,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Info"),
                Tab(text: "Videos"),
                Tab(text: "Notes"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.batchTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.batchDesc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9),
                                    borderRadius: BorderRadius.circular(90)),
                                child: Text(
                                  'Duration',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                  ),
                                  Text(
                                      '  ${widget.endDate.difference(widget.startDate).inDays} Days'),
                                  const Expanded(child: SizedBox()),
                                  Row(children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                    ),
                                    Text(
                                        'Starts : ${DateFormat("dd-MM-yyyy").format(widget.startDate)}')
                                  ]),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9),
                                    borderRadius: BorderRadius.circular(90)),
                                child: Text(
                                  'Faculty  ',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                              ),
                              Container(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: 3,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://storage-upschindi.s3.ap-south-1.amazonaws.com/data/images/avatar.png',
                                          height: 70,
                                        ),
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            'Raman',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: widget.lecture.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _infoCardWidget(context, widget.lecture[index]),
                        )
                      ],
                    ),
                  ),
                ),
                const CoursesVideoWidget(),
                Container(),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Container _infoCardWidget(BuildContext context, LectureDetail lecture) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          title: Text(lecture.lectureTitle),
          // subtitle:Text('Starts : ${DateFormat("dd-MM-yyyy",'UTC').parse(lecture.startingDate)}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '9:00 AM to 12:00 PM',
                style: TextStyle(fontSize: 15),
              ),
              const Text('Date- 08/10/2022 '),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),
            onPressed: () async {
              await [Permission.camera, Permission.microphone].request();
              callApiJoinStreamingScreen(lecture);
              //Navigator.of(context).pushNamed('joinstreaming');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Start Now', style: GoogleFonts.poppins()), // <-- Text
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<BaseModel<JoinStreaming>> callApiJoinStreamingScreen(
      LectureDetail lecture) async {
    JoinStreaming response;
    var random = Random();
    int uid = random.nextInt(999); //= 123;
    Map<String, dynamic> body = {
      "channelName": lecture.lectureTitle,
      "expireTime": "3600",
      "tokentype": "uid",
      "Stream_title": "Mahadeva@12546987",
      "account": "askd",
      "Description": lecture.description,
      "uid": uid.toString()
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      print(uid);
      String acess_token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
      response = await RestClient(RetroApi().dioData(acess_token))
          .joinmeetingRequest(body);

      if (response.status!) {
        print(response.rtmToke);
        print(response.rtcToken);
        setState(() {
          Preferences.hideDialog(context);
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JoinStreamingScreen(
                rtctoken: response.rtcToken!,
                rtmtoken: response.rtmToke!,
                uid: uid,
                lecture: lecture),
          ),
        );
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        setState(() {
          Preferences.hideDialog(context);
        });
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}

class CoursesVideoWidget extends StatelessWidget {
  const CoursesVideoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Lecture 1',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          Row(
            children: [
              Container(
                height: 60,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.gray),
                child: Icon(Icons.play_circle, color: ColorResources.textWhite),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prelims Part 1',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '1hr 2mins',
                    style: GoogleFonts.lato(
                        fontSize: 16, color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
        ]),
      ),
    );
  }
}
