import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:intl/intl.dart';
import 'package:upsc/util/images_file.dart';

class DailyNewsScreen extends StatefulWidget {
  const DailyNewsScreen({Key? key}) : super(key: key);

  @override
  State<DailyNewsScreen> createState() => _DailyNewsScreenState();
}

class _DailyNewsScreenState extends State<DailyNewsScreen> {
  String? datetoshow;
  @override
  void initState() {
    super.initState();
    datetoshow = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Daily News',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            datetoshow == DateFormat('dd-MMMM-yyyy').format(DateTime.now())
                ? 'News for Today'
                : "News for",
            style: GoogleFonts.poppins(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: ColorResources.textWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('dd-MMMM-yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                setState(() {
                  datetoshow =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$datetoshow',
                  style: GoogleFonts.poppins(color: ColorResources.textblack),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: ColorResources.textblack,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FractionallySizedBox(
            widthFactor: 0.90,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
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
                                'International News',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '2.5 MB',
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: ColorResources.gray),
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
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
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
                                'International News',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '2.5 MB',
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: ColorResources.gray),
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
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  child: Row(
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
                                'International News',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '2.5 MB',
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: ColorResources.gray),
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
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
