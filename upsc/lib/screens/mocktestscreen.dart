import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class mocktestscreen extends StatefulWidget {
  const mocktestscreen({Key? key}) : super(key: key);

  @override
  State<mocktestscreen> createState() => _mocktestscreenState();
}

class _mocktestscreenState extends State<mocktestscreen> {
  TextEditingController searchtest = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.90,
                child: TextField(
                  controller: searchtest,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Search Mock Tests, Quizzes",
                    suffixIcon: Icon(
                      Icons.search,
                      size: 30,
                    ), //icon at tail of input
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.gray),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Editorial Based Quiz',
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: const Text(
                        'Helps Improve MCQ  Solving, Attempting Daily  will help you through your preparation'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Start Now'), // <-- Text
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined),
                            const Text('10 min')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Subscribed Tests (1)',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'IAS Test Series',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '6/15 Tests Passed',
                              style: TextStyle(color: ColorResources.gray),
                            )
                          ],
                        ),
                        LinearProgressIndicator(
                          value: 0.45,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorResources.buttoncolor),
                          backgroundColor: ColorResources.gray.withOpacity(0.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pass all tests before Jan, 2023',
                              style: TextStyle(color: ColorResources.gray),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorResources.buttoncolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Continue'), // <-- Text
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Free Mock Tests',
                style: GoogleFonts.poppins(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'RAS Prelims Test Series',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('20 Tests')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.feedback),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Feedback on scores')
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('  Learn more'),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9)
                                        .withOpacity(0.38),
                                    borderRadius: BorderRadius.circular(90)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'CSAT Test Series',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('12 Tests')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.feedback),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Feedback on scores')
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('  Learn more'),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9)
                                        .withOpacity(0.38),
                                    borderRadius: BorderRadius.circular(90)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'General Studies Test Series',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('20 Tests')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.feedback),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Feedback on scores')
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('  Learn more'),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9)
                                        .withOpacity(0.38),
                                    borderRadius: BorderRadius.circular(90)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Optional Test Test Series',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('20 Tests')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.feedback),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Feedback on scores')
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('  Learn more'),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9)
                                        .withOpacity(0.38),
                                    borderRadius: BorderRadius.circular(90)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'RAS Prelims Test Series',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.exampen,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('20 Tests')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.feedback),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Feedback on scores')
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.buttoncolor,
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('  Learn more'),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFfD9D9D9)
                                        .withOpacity(0.38),
                                    borderRadius: BorderRadius.circular(90)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
