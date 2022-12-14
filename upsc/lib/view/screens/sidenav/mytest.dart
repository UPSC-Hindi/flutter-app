import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/models/Test_series/TestSeriesDetails.dart';
import 'package:upsc/util/appString..dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/sidenav/test_screen/test_detail_screen.dart';

class TestSeries extends StatefulWidget {
  final String id;
  final String name;
  const TestSeries({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<TestSeries> createState() => _TestSeriesState();
}

class _TestSeriesState extends State<TestSeries> {
  late Future<TestSeriesDetails> mytestsData;
  RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
  @override
  void initState() {
    print(widget.id);
    mytestsData = remoteDataSourceImpl.getMyTestsdetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          widget.name,
          //Languages.myTestseries,
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<TestSeriesDetails>(
          future: mytestsData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                TestSeriesDetails? myTestsModel = snapshot.data;
                return myTestsModel!.data!.isNotEmpty
                    ? testbody(myTestsModel)
                    : EmptyWidget(
                        image: SvgImages.emptyCard,
                        text: "There is no Test Series");
              } else {
                return const Text("There is no internet Connection");
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget testbody(TestSeriesDetails response) {
    return ListView.builder(
        itemCount: response.data!.length,
        itemBuilder: (context, index) {
          print(response.data![index].testTitle);
          return testcard(response.data![index]);
        });
  }

  Widget testcard(TestSeriesDetailsData carddata) {
    return Container(
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
                offset: const Offset(2, 3)),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _iconTextWidget(
                          '${carddata.noOfQuestions} Questions', Icons.menu),
                      Row(
                        children: [
                          _iconTextWidget('${carddata.totalMarks} Marks',
                              Icons.verified_outlined),
                          const SizedBox(
                            width: 5,
                          ),
                          _iconTextWidget(
                              '${carddata.duration}M Duration', Icons.alarm),
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(15),
                color: const Color(0xFFD9D9D9).withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            carddata.testTitle!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: ColorResources.textblack,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.18,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF6CBB4),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            carddata.testCode!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF7C3B33),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          carddata.startingDate!,
                          style: TextStyle(
                            color: ColorResources.gray,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Score : ${carddata.attempted!.score}',
                          style: GoogleFonts.notoSansDevanagari(
                            color: ColorResources.gray,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => TestDetailsScreen(
                                  data: carddata,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: ColorResources.buttoncolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  //'Continue'
                                  Languages.continueText,
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
                                    color: ColorResources.gray.withOpacity(0.3),
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
    );
  }

  Row _iconTextWidget(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.notoSansDevanagari(fontSize: Fontsize().h6),
        )
      ],
    );
  }
}
