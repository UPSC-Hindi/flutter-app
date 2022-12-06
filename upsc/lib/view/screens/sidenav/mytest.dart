import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/models/Test_series/MyTests.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/view/screens/sidenav/test_screen/test_detail_screen.dart';

class TestSeries extends StatefulWidget {
  TestSeries({Key? key}) : super(key: key);

  @override
  State<TestSeries> createState() => _TestSeriesState();
}

class _TestSeriesState extends State<TestSeries> {
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
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.myTestseries,
          style: GoogleFonts.notoSansDevanagari(
              color: ColorResources.textblack, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<MyTestsModel>(
          future: mytestsData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                MyTestsModel? myTestsModel = snapshot.data;
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

  Widget testbody(MyTestsModel response) {
    return ListView.builder(
      itemCount: response.data!.length,
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
                        _iconTextWidget('50 प्रश्न:', Icons.menu),
                        Row(
                          children: [
                            _iconTextWidget(
                                '100 अंक ', Icons.verified_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            _iconTextWidget('3 घंटे', Icons.alarm),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text(
                              response
                                  .data![index].testseriesId!.testseriesName!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSansDevanagari(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack,
                              ),
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
                            response.data![index].testseriesId!.startingDate!,
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
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const TestDetailsScreen(),
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
    );
  }

  Row _iconTextWidget(String text, IconData icon) {
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