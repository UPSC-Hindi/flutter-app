import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class ShortNotesScreen extends StatefulWidget {
  const ShortNotesScreen({Key? key}) : super(key: key);

  @override
  State<ShortNotesScreen> createState() => _ShortNotesScreenState();
}

class _ShortNotesScreenState extends State<ShortNotesScreen> {
  TextEditingController _searchtest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          'Short Notes',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
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
                                  'Short notes 1',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
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
                                  'Short notes 1',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
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
                                  'Short notes 1',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
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
            ),
          ],
        ),
      ),
    );
  }
}
