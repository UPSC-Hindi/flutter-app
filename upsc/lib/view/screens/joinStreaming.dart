import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/models/my_courses_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class JoinStreamingScreen extends StatefulWidget {
  final String rtctoken;
  final String rtmtoken;
  final LectureDetail lecture;
  final int uid;
  const JoinStreamingScreen(
      {Key? key,
      required this.lecture,
      required this.rtctoken,
      required this.rtmtoken,
      required this.uid})
      : super(key: key);

  @override
  State<JoinStreamingScreen> createState() => _JoinStreamingScreenState();
}

class _JoinStreamingScreenState extends State<JoinStreamingScreen> {
  static String? channel;
  static String appId =
      "5d035487d2bb4859a5faa4677c039873"; //"1541a573c5d84ce6ae3996f02626f462";//9675807e93584b4c9fec19451a1186fa
  static String? rtctoken;
  static String? name = SharedPreferenceHelper.getString(Preferences.name);
  //static int uid; //random.nextInt(999); //= 123456;
  static String? rtmtoken;
  final TextEditingController _message = TextEditingController();
  final int _selectedIndex = 0;
  int? Participants;
  List<String> chatmessges = [];

  @override
  void initState() {
    channel = widget.lecture.lectureTitle;
    rtctoken = widget.rtctoken;
    rtmtoken = widget.rtmtoken;
    initAgora();
    super.initState();
  }

// Instantiate the client
  late AgoraClient client = AgoraClient(
    agoraChannelData: AgoraChannelData(
      clientRole: ClientRole.Audience,
      channelProfile: ChannelProfile.LiveBroadcasting,
    ),
    agoraConnectionData: AgoraConnectionData(
      username: name,
      appId: appId,
      channelName: channel.toString(),
      tempToken: rtctoken,
      uid: widget.uid,
      rtmEnabled: true,
      rtmUid: widget.uid.toString(),
      rtmChannelName: channel,
      tempRtmToken: rtmtoken,
    ),
    agoraRtmChannelEventHandler: AgoraRtmChannelEventHandler(
      onMemberCountUpdated: (count) {
        Participants = count;
        print(count);
      },
      onMemberJoined: (AgoraRtmMember) async {
        print(AgoraRtmMember.toString());
      },
      onMessageReceived: (message, fromMember) {
        print('*' * 3000);
        //chatmessges.add(fromMember.userId + ':' + message.text);
        chatmessges.add(message.text);
        print(message);
        print(fromMember);
      },
    ),
    agoraRtmClientEventHandler:
        AgoraRtmClientEventHandler(onConnectionStateChanged: (p0, p1) {
      print('*' * 200);
      print(p0);
      print(p1);
    }),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: rtctoken == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Stack(
                        children: [
                          AgoraVideoViewer(
                            //showNumberOfUsers: true,
                            client: client,
                          ),
                          Positioned(
                              bottom: 0,
                              left: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        ColorResources.gray.withOpacity(0.5)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.sensors,
                                      color: ColorResources.buttoncolor,
                                    ),
                                    Text(
                                      " Live",
                                      style: TextStyle(
                                          color: ColorResources.textWhite),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                            top: 5,
                            left: -25,
                            child: AgoraVideoButtons(
                              verticalButtonPadding: 0.0,
                              client: client,
                              disconnectButtonChild: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorResources.gray.withOpacity(0.4),
                                  ),
                                  child: Icon(Icons.close,
                                      color: ColorResources.textWhite)),
                              enabledButtons: const [BuiltInButtons.callEnd],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.lecture.lectureTitle,
                                style: const TextStyle(fontSize: 30)),
                            Text(widget.lecture.description),
                            Text('By ' + widget.lecture.teacher.first),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            const Align(
                                alignment: Alignment.center,
                                child: Text('Documents Shared with you')),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorResources.gray.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(SvgImages.pdfimage),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Class 1 Notes',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '2.5 MB',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                      color:
                                                          ColorResources.gray),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.file_download_outlined,
                                          size: 40,
                                          color: ColorResources.buttoncolor,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_sharp), label: 'Participants'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: (value) {
          if (value == 0) {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
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
                                    icon: const Icon(Icons.close),
                                  ),
                                  const Text("Chat"),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: SingleChildScrollView(
                                  reverse: true,
                                  physics: const ScrollPhysics(),
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(5),
                                    itemCount: chatmessges.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorResources.gray
                                              .withOpacity(0.5),
                                        ),
                                        child: Text(chatmessges[index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _message,
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
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await client.sessionController.value
                                        .agoraRtmChannel!
                                        .sendMessage(
                                      AgoraRtmMessage.fromText(
                                          name! + _message.text),
                                    );
                                    chatmessges.add("you :" + _message.text);
                                    _message.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: ColorResources.buttoncolor,
                                  ),
                                ),
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
                                  icon: const Icon(Icons.close)),
                              Text("Participants ${Participants.toString()}"),
                            ],
                          ),
                          const Center(
                            child: Text('Participants'),
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
