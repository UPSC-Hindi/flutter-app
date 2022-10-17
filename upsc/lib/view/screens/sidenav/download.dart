import 'package:flutter/material.dart';
import 'package:upsc/features/presentation/widgets/empty_widget.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';

import '../../../util/images_file.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          Languages.download,
          style: TextStyle(color: ColorResources.textblack),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: ColorResources.buttoncolor,
                  unselectedLabelColor: ColorResources.gray,
                  labelColor: ColorResources.buttoncolor,
                  tabs: [
                    Tab(text: Languages.video),
                    Tab(text: Languages.testSeries),
                    Tab(text: Languages.resources),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  // Column(
                  //   children: [
                  //     _videoCardWidget(context),
                  //   ],
                  // ),
                  EmptyWidget(image: SvgImages.emptyCard, text: "There in no Videos"),
                  EmptyWidget(image: SvgImages.emptyCard, text: "There in no Test Series"),
                  EmptyWidget(image: SvgImages.emptyCard, text: "There in no Resources"),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _videoCardWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.gray),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: const Icon(
              Icons.play_circle_fill_outlined,
              size: 50,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'General Studies Part 1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("1hr 5mins"),
            ],
          )
        ],
      ),
    );
  }
}
