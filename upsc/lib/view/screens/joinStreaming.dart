import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

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
  static String appId =
      "5d035487d2bb4859a5faa4677c039873"; //"1541a573c5d84ce6ae3996f02626f462";//9675807e93584b4c9fec19451a1186fa
  static String? rtctoken;
  static String? name = SharedPreferenceHelper.getString(Preferences.name);
  //static int uid; //random.nextInt(999); //= 123456;
  static String? rtmtoken;
  final TextEditingController _message = TextEditingController();
  final int _selectedIndex = 0;

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
        onMemberJoined: (AgoraRtmMember) async {
          print(AgoraRtmMember);
        },
        onMessageReceived: (message, fromMember) {
          print('*' * 3000);
          print(message);
          print(fromMember);
        },
      ),
      agoraRtmClientEventHandler:
          AgoraRtmClientEventHandler(onConnectionStateChanged: (p0, p1) {
        print('*' * 200);
        print(p0);
        print(p1);
      }));

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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: rtctoken == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Stack(
                      children: [
                        AgoraVideoViewer(
                          //showNumberOfUsers: true,
                          client: client,
                        ),
                        Positioned(
                          top: 10,
                          left: -10,
                          child: AgoraVideoButtons(
                            verticalButtonPadding: 0.0,
                            client: client,
                            disconnectButtonChild: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorResources.gray.withOpacity(0.5),
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
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.channelName,
                              style: TextStyle(fontSize: 30)),
                          Text('Course Info'),
                          Text('By Lorem Ipsum'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text('Documents Shared with you')),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorResources.gray),
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
                                          SizedBox(
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
                                                    color: ColorResources.gray),
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
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.close),
                                ),
                                const Text("Chat"),
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
                                  controller: _message,
                                  //autofocus: true,
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
                                  await client
                                      .sessionController.value.agoraRtmChannel!
                                      .sendMessage(
                                    AgoraRtmMessage.fromText(_message.text),
                                  );
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                              const Text("Participants (170)")
                            ],
                          ),
                          const Center(
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
