import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          Languages.helpAndSupport,
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            Languages.freeMessage,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.email,
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Languages.emailText,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'upschindi4cse@gmail.com',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Languages.phoneText,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '+91  951 978 0078',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.whatsapp,
                    size: 60,
                  ),
                  Text(Languages.whatsApp),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity * 0.40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "https://www.facebook.com/UPSCHINDI4CSE"));
                            },
                            child: Icon(Icons.facebook)),
                        GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "https://twitter.com/upschindi4cse"));
                            },
                            child: Icon(Icons.tab_sharp)),
                        GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "https://www.instagram.com/upschindi4cse"));
                            },
                            child: Icon(Icons.linked_camera_outlined))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
