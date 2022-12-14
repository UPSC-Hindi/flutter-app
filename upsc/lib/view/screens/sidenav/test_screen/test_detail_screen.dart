import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/Test_series/TestSeriesDetails.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/sidenav/test_screen/test_submit.dart';
import 'package:url_launcher/url_launcher.dart';

class TestDetailsScreen extends StatefulWidget {
  final TestSeriesDetailsData data;
  const TestDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          //Languages.myTestseries,
          widget.data.testTitle!,
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.gray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "-ve",
                                  style: GoogleFonts.notoSansDevanagari(
                                      color: ColorResources.buttoncolor),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Negative  Marking"),
                              ],
                            ),
                            Switch(
                              value: widget.data.negativemarking!,
                              activeColor: ColorResources.buttoncolor,
                              onChanged: (value) {},
                            )
                          ],
                        ),
                      ),
                      Text('Description',
                          style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          //'Lorem Ipsum is simply dummy text of the printing and'
                          //'typesetting industry. Lorem Ipsum has been the industry'
                          //'standard dummy text ever since the 1500s, when an'
                          //'unknown printer took a galley of type and scrambled'
                          //'it to make a type specimen book'
                          widget.data.instructions!,
                          style: GoogleFonts.notoSansDevanagari()),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: const Color(0xFFD9D9D9).withOpacity(0.3),
                        child: ListTile(
                          title: Text(
                            Languages.questionpaper,
                            style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: ColorResources.textblack,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              flutterToast("downloading..");
                              download(widget.data.questionPaper!.fileLoc,
                                  widget.data.questionPaper!.fileName);
                              // launchUrl(
                              //     Uri.parse(
                              //         widget.data.questionPaper!.fileLoc!),
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: ColorResources.buttoncolor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PDF',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorResources.textWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.download_outlined,
                                    size: 18,
                                    color: ColorResources.textWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.data.isAttempted!
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              color: const Color(0xFFD9D9D9).withOpacity(0.3),
                              child: ListTile(
                                title: Text(
                                  "Your Answer Sheet",
                                  style: GoogleFonts.notoSansDevanagari(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: ColorResources.textblack,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    flutterToast("downloading..");
                                    download(
                                        widget.data.attempted!.answerSheet!
                                            .fileLoc,
                                        widget.data.attempted!.answerSheet!
                                            .fileName);
                                    // launchUrl(
                                    //     Uri.parse(widget.data.attempted!
                                    //         .answerSheet!.fileLoc!),
                                    //     mode: LaunchMode.externalApplication);
                                  },
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: ColorResources.buttoncolor,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'PDF',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorResources.textWhite,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Icon(
                                          Icons.download_outlined,
                                          size: 18,
                                          color: ColorResources.textWhite,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget.data.isAttempted!
                          ? widget.data.attempted!.checkedAnswerSheet!
                                      .fileLoc !=
                                  ""
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color:
                                      const Color(0xFFD9D9D9).withOpacity(0.3),
                                  child: ListTile(
                                    title: Text(
                                      Languages.CheckedAnswer,
                                      style: GoogleFonts.notoSansDevanagari(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: ColorResources.textblack,
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        flutterToast("downloading..");
                                        download(
                                            widget.data.attempted!
                                                .checkedAnswerSheet!.fileLoc,
                                            widget.data.attempted!
                                                .checkedAnswerSheet!.fileName);
                                        // launchUrl(
                                        //     Uri.parse(widget.data.attempted!
                                        //         .answerSheet!.fileLoc!),
                                        //     mode: LaunchMode.externalApplication);
                                      },
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        backgroundColor:
                                            ColorResources.buttoncolor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'PDF',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: ColorResources.textWhite,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Icon(
                                              Icons.download_outlined,
                                              size: 18,
                                              color: ColorResources.textWhite,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                          : Text(""),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: const Color(0xFFD9D9D9).withOpacity(0.3),
                        child: ListTile(
                          title: Text(
                            Languages.OMR_Sheet,
                            style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: ColorResources.textblack,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              flutterToast("downloading..");
                              download(widget.data.answerTemplate!.fileLoc,
                                  widget.data.answerTemplate!.fileName);
                              // launchUrl(
                              //     Uri.parse(
                              //         widget.data.answerTemplate!.fileLoc!),
                              //     mode: LaunchMode.externalApplication);
                            },
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: ColorResources.buttoncolor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PDF',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorResources.textWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.download_outlined,
                                    size: 18,
                                    color: ColorResources.textWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Don't delete this box it give bottom padding
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => TestSubmitScreen(
                          questionPaper: widget.data.questionPaper!.fileLoc!,
                          name: widget.data.testTitle!,
                          id: widget.data.sId!,
                          examtype: widget.data.questionPaperType!),
                    ));
                  },
                  child: SizedBox(
                    height: 45,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.data.isAttempted!
                            ? Languages.StartTest
                            : Languages.Startagain,
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  download(url, name) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;
    var dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    // downloads the file
    Dio dio = Dio();
    await dio.download(url, "${dir.path}/${name!}.${url.split('.').last}");
    OpenFile.open("${dir.path}/${name!}.${url.split('.').last}",
        type: 'application/pdf');
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}
