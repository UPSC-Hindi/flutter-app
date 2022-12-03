
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/utils/color_resources.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
  Widget customRadio(
      String text, String src, int index, bool tick, BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          width: 2,
          style: BorderStyle.solid,
          // color: selected == index
            color: true
              ? ColorResources.buttoncolor
              : ColorResources.gray.withOpacity(0.5),
        ),
      ),
      onPressed: () {
        // TODO : dinesh create this thing using cubit
        // setState(() {
        //   selected = index;
        //   Lcount = Lcount + 1;
        // });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.width * 0.22,
              child: Column(children: [
                Text(
                  src,
                  style: GoogleFonts.notoSansDevanagari(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                //SizedBox(height: 60, child: SvgPicture.asset(src)),
                Text(
                  text,
                  style: GoogleFonts.notoSansDevanagari(
                      color: Colors.black, fontSize: 12),
                ),
              ]),
            ),
            // selected == index
        true
                ? const Positioned(
                top: 5,
                left: 0,
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFFF05266),
                ))
                : const Text('')
          ],
        ),
      ),
    );
  }
}
