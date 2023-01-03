import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image,
            height: 80,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: GoogleFonts.notoSansDevanagari(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
