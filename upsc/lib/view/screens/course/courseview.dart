import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/joinStreaming.dart';

class CourseViewScreen extends StatefulWidget {
  const CourseViewScreen({Key? key, required this.chanelName, required this.description}) : super(key: key);
  final String chanelName;
  final String description;
  @override
  State<CourseViewScreen> createState() => _CourseViewScreenState();
}

class _CourseViewScreenState extends State<CourseViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CourseViewScreen'),
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
                    Tab(text: "Videos"),
                    Tab(text: "Tests"),
                    Tab(text: "Notes"),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.gray),
                                  child: Icon(Icons.play_circle,
                                      color: ColorResources.textWhite),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Prelims Part 1',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '1hr 2mins',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ]),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Courses',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Courses',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorResources.buttoncolor,
          onPressed: () async {
            await [Permission.camera, Permission.microphone].request();
            callApiJoinStreamingScreen();
            //Navigator.of(context).pushNamed('joinstreaming');
          },
          child: Center(
            child: Column(
              children: [Icon(Icons.sensors_outlined), Text('live')],
            ),
          ),
        ));
  }

  Future<BaseModel<JoinStreaming>> callApiJoinStreamingScreen() async {
    JoinStreaming response;
    var random = Random();
    String channelName = "Lecture 1";
    int uid = random.nextInt(999); //= 123;
    Map<String, dynamic> body = {
      "channelName": channelName,
      "expireTime": "3600",
      "tokentype": "uid",
      "Stream_title": "Mahadeva@12546987",
      "account": "askd",
      "Description": "A new Meeting",
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
        print(channelName);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JoinStreamingScreen(
                rtctoken: response.rtcToken!,
                rtmtoken: response.rtmToke!,
                uid: uid,
                channelName: channelName),
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
