import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';

class TestSubmitScreen extends StatefulWidget {
  final String id;
  const TestSubmitScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<TestSubmitScreen> createState() => _TestSubmitScreenState();
}

class _TestSubmitScreenState extends State<TestSubmitScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(hours: 3);
  FilePickerResult? result;
  PlatformFile? file;
  bool selectfile = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'TestSubmitScreen',
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_sharp),
                Text(
                  '$hours:$minutes:$seconds',
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null) {
                file = result!.files.single;
                setState(() {
                  print(file);
                  selectfile = true;
                });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.50,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: ColorResources.buttoncolor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'Upload OMR',
                style: GoogleFonts.notoSansDevanagari(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          selectfile ? Text(file!.path!) : const Text(""),
          const SizedBox(
            height: 200,
          ),
          selectfile
              ? GestureDetector(
                  onTap: () {
                    fileupload();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorResources.buttoncolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sumbit',
                          style: GoogleFonts.notoSansDevanagari(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorResources.textWhite,
                        )
                      ],
                    ),
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }

  fileupload() async {
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      Response response =
          await RemoteDataSourceImpl().submit_answer(file!, widget.id);
      if (response.statusCode == 200) {
        setState(() {
          Preferences.hideDialog(context);
        });
        flutterToast(response.data['msg']);
      } else {
        setState(() {
          Preferences.hideDialog(context);
        });
        flutterToast(response.data['msg']);
      }
    } catch (error) {
      setState(() {
        Preferences.hideDialog(context);
      });
      flutterToast('Server Error');
    }
  }
}
