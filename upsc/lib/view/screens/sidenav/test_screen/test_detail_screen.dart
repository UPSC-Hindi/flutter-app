import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';

class TestDetailsScreen extends StatelessWidget {
  const TestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.myTestseries,
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description'),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'Lorem Ipsum is simply dummy text of the printing and'
                    'typesetting industry. Lorem Ipsum has been the industry'
                    'standard dummy text ever since the 1500s, when an'
                    'unknown printer took a galley of type and scrambled'
                    'it to make a type specimen book'),
                const SizedBox(
                  height: 250,
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Color(0xFFD9D9D9).withOpacity(0.3),
                  child: ListTile(
                    title: Text(
                      'RAS Prelims Test Series-1',
                      style: GoogleFonts.notoSansDevanagari(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: ColorResources.textblack,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: ColorResources.buttoncolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PDF',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorResources.textWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.download_outlined,
                                size: 18,
                                color: ColorResources.textWhite,
                              )
                            ],
                          ),
                        ),
                        Text('View ORM >',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: const Color(0xFFD9D9D9).withOpacity(0.3),
                  child: ListTile(
                    title: Text(
                      'RAS Prelims Test Series-1',
                      style: GoogleFonts.notoSansDevanagari(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: ColorResources.textblack,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: ColorResources.buttoncolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PDF',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorResources.textWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.download_outlined,
                                size: 18,
                                color: ColorResources.textWhite,
                              )
                            ],
                          ),
                        ),
                        Text('View ORM >',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),)
                      ],
                    ),
                  ),
                ),

                //Don't delete this box it give bottom padding
                SizedBox(
                  height: 50,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Take Live Test',
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text('Or'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Take Live Test',
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
