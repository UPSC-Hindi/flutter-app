import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/models/Test_series/TestSeriesDetails.dart';
import 'package:upsc/util/color_resources.dart';
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
                        children: const [
                          Text("-ve"),
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
                    widget.data.instructions!),
                const SizedBox(
                  height: 250,
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: const Color(0xFFD9D9D9).withOpacity(0.3),
                  child: ListTile(
                    title: Text(
                      "Question Paper",
                      style: GoogleFonts.notoSansDevanagari(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: ColorResources.textblack,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse(widget.data.questionPaper!.fileLoc!),
                            mode: LaunchMode.externalApplication);
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
                            "Your Checked Answer Sheet",
                            style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: ColorResources.textblack,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              launchUrl(
                                  Uri.parse(widget
                                      .data.attempted!.answerSheet!.fileLoc!),
                                  mode: LaunchMode.externalApplication);
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
                      )
                    : Text(""),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: const Color(0xFFD9D9D9).withOpacity(0.3),
                  child: ListTile(
                    title: Text(
                      'OMR Sheet',
                      style: GoogleFonts.notoSansDevanagari(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: ColorResources.textblack,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse(widget.data.answerTemplate!.fileLoc!),
                            mode: LaunchMode.externalApplication);
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
                const SizedBox(
                  height: 50,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TestSubmitScreen(
                        questionPaper:widget.data.questionPaper!.fileLoc!,
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
                      widget.data.isAttempted! ? "Start Again " : 'Start Test',
                      style: GoogleFonts.notoSansDevanagari(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
