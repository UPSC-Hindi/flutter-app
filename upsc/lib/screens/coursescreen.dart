import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class coursescreen extends StatelessWidget {
  const coursescreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: ColorResources.buttoncolor,
                  labelColor: ColorResources.buttoncolor,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Prelims"),
                    Tab(text: "Mains"),
                    Tab(text: "Interview"),
                    Tab(text: "RO"),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Courses',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Test Series',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'RAS Prelims Test Series',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Courses',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
                                  children: [
                                    const Text(
                                      'Course 1',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: const [
                                            Icon(Icons.sensors_outlined),
                                            Text(
                                              'Live lectures',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.signal_cellular_alt),
                                            Text(
                                              '100% Online',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Icon(Icons.download),
                                            Text(
                                              'Downloadable',
                                              style: TextStyle(fontSize: 8),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          '₹15,000',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: ColorResources.greenshad),
                                          child: Text(
                                            'Aid Available',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    ColorResources.textWhite),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder()),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('  Learn more'),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFfD9D9D9)
                                                    .withOpacity(0.38),
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Test Series',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Test Series 1',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'RAS Prelims Test Series',
                                      style: TextStyle(fontSize: 20),
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
                                      children: const [
                                        Icon(Icons.feedback),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Feedback on scores')
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.buttoncolor,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('  Learn more'),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFfD9D9D9)
                                                      .withOpacity(0.38),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
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
                  ),
                  SingleChildScrollView(
                    child: Column(children: const [
                      Text('Mock Interview     '),
                      SizedBox(height: 300),
                      Text('Script')
                    ]),
                  ),
                  const Center(
                    child: Text("ro"),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
