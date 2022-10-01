import 'dart:async';
import 'dart:math';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/joinstreaming.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class JoinStreamingScreen extends StatefulWidget {
  const JoinStreamingScreen({Key? key}) : super(key: key);

  @override
  State<JoinStreamingScreen> createState() => _JoinStreamingScreenState();
}

class _JoinStreamingScreenState extends State<JoinStreamingScreen> {
  static late String channelName; //= "Lecture 3";
  static String appId = "9675807e93584b4c9fec19451a1186fa";
  static String?
      token; //=  "0069675807e93584b4c9fec19451a1186faIACABCFw8t1KqI6VlLfHVGZ4lm+37yOevibx4iPnh1R8ERoYBfhh03IJEAC/CDmiITI4YwEAAQCw7jZj";
  static var random = Random();
  static int uid = random.nextInt(999999); //= 123456;
  var isloading = true;

  @override
  void initState() {
    super.initState();
    callApiJoinStreamingScreen();
    initAgora();
  }

// Instantiate the client
  final AgoraClient client = AgoraClient(
    agoraChannelData: AgoraChannelData(
        clientRole: ClientRole.Audience,
        channelProfile: ChannelProfile.LiveBroadcasting),
    agoraConnectionData: AgoraConnectionData(
        appId: appId, channelName: channelName, tempToken: token, uid: uid),
  );

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> endCall({required SessionController sessionController}) async {
    await sessionController.value.engine?.leaveChannel();
    if (sessionController.value.connectionData!.rtmEnabled) {
      await sessionController.value.agoraRtmChannel?.leave();
      await sessionController.value.agoraRtmClient?.logout();
    }
    await sessionController.value.engine?.destroy();
  }

  @override
  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : AgoraVideoViewer(
                    showNumberOfUsers: true,
                    client: client,
                  ),
          ],
        ),
      ),
    );
  }

  Future<BaseModel<JoinStreaming>> callApiJoinStreamingScreen() async {
    JoinStreaming response;
    Map<String, dynamic> body = {
      "channelName": "main",
      "expireTime": "3600",
      "tokentype": "uid",
      "Stream_title": "Mahadeva@12546987",
      "account": "askd",
      "Description": "A new Meeting",
      "uid": uid
    };
    try {
      String acess_token =
          SharedPreferenceHelper.getString(Preferences.access_token).toString();
      response = await RestClient(RetroApi().dioData(acess_token))
          .joinmeetingRequest(body);
     
      if (response.status!) {
        setState(() {
          isloading=false;
          token = response.data!.rtcToken;
          print(token);
        });
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
