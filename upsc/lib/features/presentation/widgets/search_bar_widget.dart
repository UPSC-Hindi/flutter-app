import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required TextEditingController searchtest,
  })  : _searchtest = searchtest,
        super(key: key);

  final TextEditingController _searchtest;

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
        controller: _searchtest,
        style: GoogleFonts.notoSansDevanagari(
            fontSize: 16.0, color: ColorResources.gray),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: "Search Notes",
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
