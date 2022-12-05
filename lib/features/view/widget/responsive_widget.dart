
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({Key? key, required this.mobile, required this.web, required this.tab}) : super(key: key);
  final Widget mobile;
  final Widget tab;
  final Widget web;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth<600){
        return mobile;
      }else if(constraints.maxWidth>600 &&constraints.maxWidth<1100){
        return tab;
      }
      return web;
    });
  }
}


var myDrawer = Drawer(
  child: Column(
    children: [
      DrawerHeader(
        child: Container(
          decoration: BoxDecoration(
            color: ColorResources.buttoncolor,
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About Us",
                style: GoogleFonts.notoSansDevanagari(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorResources.textblack),),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          PreferencesHelper.clearPref();
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16, top: 0, bottom: 10, right: 30),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('Logout',
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.redAccent,
                    ))
              ],
            ),
          ),
        ),
      )
    ],
  ),
);