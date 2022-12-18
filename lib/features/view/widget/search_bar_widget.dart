import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/utils/color_resources.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required this.onChanged,
    required this.searchText,
  }) : super(key: key);
  final ValueChanged<String> onChanged;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorResources.borderColor),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 2,
              color: ColorResources.borderColor,
            ),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.notoSansDevanagari(
          fontSize: 16.0,
          color: ColorResources.gray,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: searchText,
          suffixIcon: Icon(
            Icons.search,
            size: 22,
            color: ColorResources.buttoncolor,
          ), //icon at tail of input
        ),
      ),
    );
  }
}
