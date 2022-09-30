import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Size get preferredSize => const Size.fromHeight(400.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomPaint(
          painter: MyPainter(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorResources.textWhite,
                    ),
                  ),
                ),
                Image.asset(
                  SvgImages.logo,
                  height: 100,
                ),
                Text(
                  'We’re here to Solve',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: ColorResources.textWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
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
      ]),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = ColorResources.buttoncolor;
    path = Path();
    path.lineTo(size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, size.height * 0.76, 0, size.height * 0.76);
    path.cubicTo(size.width / 4, size.height * 1.1, size.width * 0.79,
        size.height * 1.05, size.width, size.height * 0.76);
    path.cubicTo(size.width, size.height * 0.76, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, 0, size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
