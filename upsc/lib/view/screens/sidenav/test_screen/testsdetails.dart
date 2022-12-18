import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/models/Test_series/testSerie.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/screens/sidenav/test_screen/testseriesPaymentScreen.dart';

class TestSeriesDetailScreen extends StatefulWidget {
  final String testseriesId;
  final TestSeriesData testseriesName;
  const TestSeriesDetailScreen(
      {Key? key, required this.testseriesId, required this.testseriesName})
      : super(key: key);

  @override
  State<TestSeriesDetailScreen> createState() => _TestSeriesDetailScreenState();
}

class _TestSeriesDetailScreenState extends State<TestSeriesDetailScreen> {
  List<Widget> image = [];

  @override
  void initState() {
    widget.testseriesName.banner!.forEach((element) {
      image.add(Image.network(element.fileLoc!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          widget.testseriesName.testseriesName!,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: CarouselSlider(
                      items: image,
                      options: CarouselOptions(
                        height: 140,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xFfD9D9D9),
                              borderRadius: BorderRadius.circular(90)),
                          child: Text(
                            '  Course Details  ',
                            style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.testseriesName.description!,
                            style: GoogleFonts.lato(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        widget.testseriesName.remark!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Note: ",
                                          style: GoogleFonts.notoSansDevanagari(
                                              fontSize: 20,
                                              color:
                                                  ColorResources.buttoncolor),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          child: Text(
                                            widget.testseriesName.remark!,
                                            style:
                                                GoogleFonts.lato(fontSize: 16),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : const Text(''),
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 20 / 4,
                          shrinkWrap: true,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.play_circle_fill_outlined,
                              ),
                              Text('  ${widget.testseriesName.noOfTest} Tests')
                            ]),
                            Row(children: [
                              const Icon(
                                Icons.person,
                              ),
                              Text(
                                  ' ${widget.testseriesName.student!.length} Taken')
                            ]),
                            Row(children: [
                              Icon(
                                Icons.sensors_outlined,
                                color: ColorResources.buttoncolor,
                              ),
                              Text(' Live Access')
                            ]),
                            Row(children: const [
                              Icon(
                                Icons.people,
                              ),
                              Text(' Best Recommended')
                            ]),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xFfD9D9D9),
                              borderRadius: BorderRadius.circular(90)),
                          child: Text(
                            '  Duration  ',
                            style: GoogleFonts.notoSansDevanagari(fontSize: 16),
                          ),
                        ),
                        GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            crossAxisCount: 1,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 20 / 4,
                            shrinkWrap: true,
                            children: [
                              Row(children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                ),
                                Text(
                                    ' Starts : ${widget.testseriesName.startingDate}')
                              ]),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '₹${widget.testseriesName.charges}',
                    style: GoogleFonts.notoSansDevanagari(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorResources.buttoncolor,
                          shape: const StadiumBorder()),
                      onPressed: () {
                        //callApiaddtocart(course.data.batchDetails.id);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TestPaymentScreen(
                              testseries: widget.testseriesName),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 5.0),
                        child: Text('Make Payment',
                            style:
                                GoogleFonts.notoSansDevanagari(fontSize: 20)),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
