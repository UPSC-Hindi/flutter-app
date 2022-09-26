import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/color_resources.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(color: ColorResources.textblack),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Feel free to message us at',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.email,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mail us at',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'upschindi@xyzmail.com',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '+91 9999 999 999',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.whatsapp,
                    size: 60,
                  ),
                  Text('Whatsapp Us!'),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity * 0.40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.facebook),
                        Icon(Icons.tab_sharp),
                        Icon(Icons.linked_camera_outlined)
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
