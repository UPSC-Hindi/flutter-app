import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class YoutubeNotesScreen extends StatefulWidget {
  const YoutubeNotesScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeNotesScreen> createState() => _YoutubeNotesScreenState();
}

class _YoutubeNotesScreenState extends State<YoutubeNotesScreen> {
  TextEditingController _searchtest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Youtube Notes',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchtest,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Notes",
                suffixIcon: Icon(
                  Icons.search,
                  size: 30,
                ), //icon at tail of input
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              children: [
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(SvgImages.pdfimage),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Youtube Class 1 Notes',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
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
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorResources.gray),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_circle_right_rounded,
                                      color: ColorResources.gray),
                                  label: Text(
                                    "Watch on YouTube",
                                    style: GoogleFonts.poppins(
                                        color: ColorResources.textblack),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(SvgImages.pdfimage),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Youtube Class 1 Notes',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
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
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorResources.gray),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_circle_right_rounded,
                                      color: ColorResources.gray),
                                  label: Text(
                                    "Watch on YouTube",
                                    style: GoogleFonts.poppins(
                                        color: ColorResources.textblack),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(SvgImages.pdfimage),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Youtube Class 1 Notes',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
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
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorResources.gray),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_circle_right_rounded,
                                      color: ColorResources.gray),
                                  label: Text(
                                    "Watch on YouTube",
                                    style: GoogleFonts.poppins(
                                        color: ColorResources.textblack),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
