import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/notificationget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Data> notificationData = [];

  bool isloading = true;

  @override
  void initState() {
    callApinotication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/notification_bg1.png'),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/notification-bg2.png',
                color: Colors.pinkAccent.withOpacity(0.3),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          Languages.Notification,
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : notificationData.isEmpty
                          ? Container(
                              height: 130,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/images/notificationCurve.png',
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: Offset(0, 9),
                                  ),
                                ],
                              ),
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.pinkAccent.withOpacity(0.2),
                                    child: Icon(
                                      Icons.notifications_none_outlined,
                                      color: ColorResources.resourcesCardColor,
                                      size: 35,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'No notification',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: notificationData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          'assets/images/notificationCurve.png'),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: Offset(0, 9),
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: ListTile(
                                    // leading: Container(
                                    //   decoration: BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //   ),
                                    //   child: Image.network(
                                    //     SvgImages.avatar,
                                    //     height: 45,
                                    //   ),
                                    // ),
                                    horizontalTitleGap: 4,
                                    title: Text(
                                      notificationData[index].message!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      (notificationData[index].createdAt!),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<BaseModel<NotificationGet>> callApinotication() async {
    NotificationGet response;
    try {
      var token = SharedPreferenceHelper.getString(Preferences.access_token);
      response =
          await RestClient(RetroApi().dioData(token!)).getnotificationRequest();
      setState(() {
        notificationData = response.data!;
        notificationData.sort((a, b) => (a.createdAt!.compareTo(b.createdAt!)));
        isloading = false;
      });
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
