import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/models/Test_series/MyTests.dart';
import 'package:upsc/models/Test_series/testSerie.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/view/screens/sidenav/test_screen/test_detail_screen.dart';
import 'package:upsc/view/screens/sidenav/test_screen/testsdetails.dart';

class mocktestscreen extends StatefulWidget {
  final RemoteDataSourceImpl remoteDataSourceImpl;
  const mocktestscreen({Key? key, required this.remoteDataSourceImpl})
      : super(key: key);

  @override
  State<mocktestscreen> createState() => _mocktestscreenState();
}

class _mocktestscreenState extends State<mocktestscreen> {
  TextEditingController searchtest = TextEditingController();
  late Future<MyTestsModel> mytestsData;
  RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
  @override
  void initState() {
    mytestsData = remoteDataSourceImpl.getMyTests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TestSeries>(
          future: widget.remoteDataSourceImpl.getTestSeries(),
          builder: (context, snapshots) {
            if (ConnectionState.done == snapshots.connectionState) {
              if (snapshots.hasData) {
                TestSeries? response = snapshots.data;
                if (response!.status!) {
                  return testscreenbody(
                    response.data,
                  );
                } else {
                  return Text(response.msg!);
                }
              } else {
                return const Text('Server Error');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget testscreenbody(List<TestSeriesData>? response) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Center(
          //   child: Container(
          //     margin: const EdgeInsets.all(10),
          //     width: MediaQuery.of(context).size.width * 0.90,
          //     child: TextField(
          //       controller: searchtest,
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //         labelText: "Search Mock Tests, Quizzes",
          //         suffixIcon: Icon(
          //           Icons.search,
          //           size: 30,
          //         ), //icon at tail of input
          //       ),
          //     ),
          //   ),
          // ),
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
                  style: GoogleFonts.notoSansDevanagari(
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
                      Row(
                        children: [
                          const Icon(Icons.access_time_outlined),
                          const Text('10 min')
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorResources.buttoncolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'mytestseries');
                        },
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<MyTestsModel>(
            future: mytestsData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  MyTestsModel? myTestsModel = snapshot.data;
                  return myTestsModel!.data!.isNotEmpty
                      ? myTestsbody(myTestsModel)
                      : const Text("");
                } else {
                  return const Text("There is no internet Connection");
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Mock Tests',
              style: GoogleFonts.notoSansDevanagari(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: response!.length,
            itemBuilder: (BuildContext context, int index) {
              return testseriesCard(response[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget myTestsbody(MyTestsModel response) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Tests',
            style: GoogleFonts.notoSansDevanagari(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: response.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return _mytestsCard(response.data![index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _mytestsCard(Data response) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        response.testseriesId!.testseriesName!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSansDevanagari(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '6/15 Tests Passed',
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.gray),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Starting on ${response.testseriesId!.startingDate}',
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.gray),
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
    );
  }

  Widget testseriesCard(TestSeriesData response) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            response.testseriesName!,
            style: GoogleFonts.notoSansDevanagari(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.network(
                    SvgImages.pdfimage,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${response.noOfTest!} Tests')
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.feedback),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("for ${response.stream} ${response.examType}")
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Starting on ${response.startingDate}"),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ColorResources.buttoncolor,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TestSeriesDetailScreen(
                            testseriesId: response.sId!,
                            testseriesName: response),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('  Learn more'),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: const Color(0xFfD9D9D9).withOpacity(0.38),
                            borderRadius: BorderRadius.circular(90)),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
