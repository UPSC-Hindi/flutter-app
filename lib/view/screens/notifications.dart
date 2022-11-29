import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/notificationget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Data> notificationData = [];

  @override
  void initState() {
    callApinotication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'NotificationScreen',
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: notificationData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationData[index].title!,
                      style: GoogleFonts.poppins(fontSize: 24),
                    ),
                    Text(notificationData[index].message!),
                  ],
                ),
              ),
            ),
          );
        },
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
        print(response.data);
        notificationData = response.data!;
      });
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
