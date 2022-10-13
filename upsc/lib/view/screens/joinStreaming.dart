import 'dart:async';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class JoinStreamingScreen extends StatefulWidget {
  final String rtctoken;
  final String rtmtoken;
  final String channelName;
  final int uid;
  const JoinStreamingScreen(
      {Key? key,
      required this.channelName,
      required this.rtctoken,
      required this.rtmtoken,
      required this.uid})
      : super(key: key);

  @override
  State<JoinStreamingScreen> createState() => _JoinStreamingScreenState();
}

class _JoinStreamingScreenState extends State<JoinStreamingScreen> {
  static String? channel;
  static String appId = "5d035487d2bb4859a5faa4677c039873";//"1541a573c5d84ce6ae3996f02626f462";//9675807e93584b4c9fec19451a1186fa
  static String? rtctoken;
  //static int uid; //random.nextInt(999); //= 123456;
  static String? rtmtoken;

  int _selectedIndex = 0;

  @override
  void initState() {
    channel = widget.channelName;
    rtctoken = widget.rtctoken;
    rtmtoken = widget.rtmtoken;
    initAgora();
    super.initState();
  }

// Instantiate the client
  late AgoraClient client = AgoraClient(
    agoraChannelData: AgoraChannelData(
        clientRole: ClientRole.Audience,
        channelProfile: ChannelProfile.LiveBroadcasting),
    agoraConnectionData: AgoraConnectionData(
      appId: appId,
      channelName: channel.toString(),
      tempToken: rtctoken,
      uid: widget.uid,
      rtmEnabled: true,
      rtmUid: widget.uid.toString(),
      rtmChannelName: channel,
      tempRtmToken: rtmtoken,
    ),
  );

  @override
  void dispose() {
    endthesession(sessionController: client.sessionController);
    super.dispose();
  }

  Future<void> endthesession(
      {required SessionController sessionController}) async {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: rtctoken == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Stack(
                  children: [
                    AgoraVideoViewer(
                      showNumberOfUsers: true,
                      client: client,
                    ),
                    Positioned(
                      top: 10,
                      left: -10,
                      child: AgoraVideoButtons(
                        verticalButtonPadding: 0.0,
                        client: client,
                        disconnectButtonChild: Icon(Icons.close),
                        enabledButtons: [BuiltInButtons.callEnd],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_sharp), label: 'Courses'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: (value) {
          if (value == 0) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.70,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: Icon(Icons.close)),
                                  Text("Chat"),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: ColorResources.gray,
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorResources.gray,
                                          width: 1.0),
                                    ),
                                    hintText: 'message',
                                  ),
                                )),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.send))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(Icons.close)),
                              Text("Participants (170)")
                            ],
                          ),
                          Center(
                            child: Text('Participants (170)'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
