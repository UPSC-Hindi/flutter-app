import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';

class TestSeries extends StatelessWidget {
  const TestSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(2, 3)),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _iconTextWidget('50 प्रश्न:',Icons.menu),
                          Row(
                            children: [
                              _iconTextWidget('100 अंक ',Icons.alarm),
                              SizedBox(
                                width: 20,
                              ),
                              _iconTextWidget('3 घंटे',Icons.verified_outlined),
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Color(0xFFD9D9D9).withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'RAS Prelims Test Series-1',
                              style: GoogleFonts.notoSansDevanagari(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6CBB4),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                '34567',
                                style: TextStyle(
                                  color: Color(0xFF7C3B33),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '18-11-2022',
                              style: TextStyle(
                                color: ColorResources.gray,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Score : 10/100',
                              style: TextStyle(
                                color: ColorResources.gray,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: ColorResources.buttoncolor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Explore',
                                    style: GoogleFonts.notoSansDevanagari(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ), // <-- Text
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color:
                                          ColorResources.gray.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _iconTextWidget(String text,IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(text)
      ],
    );
  }
}