import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          iconTheme: IconThemeData(color: ColorResources.textblack),
          title: Text(
            'Resources',
            style: TextStyle(color: ColorResources.textblack),
          ),
        ),
        body: GridView.count(
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              childAspectRatio: 7 / 8,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('dailynews'),
                  child: _resourceCardWidget(
                      SvgImages.dailyNews, 'Daily News'),
                ),
                GestureDetector(
                  child: _resourceCardWidget(
                      SvgImages.courseIndex, 'Course Index'),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('shortnotes'),
                  child: _resourceCardWidget(
                      SvgImages.shortNotes, 'Short Notes'),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('youtubenotes'),
                  child: _resourceCardWidget(
                      SvgImages.youtubeNotes, 'Youtube Note'),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('samplenotes'),
                  child: _resourceCardWidget(
                      SvgImages.sampleNotes, 'Sample Notes'),
                ),
              ],
            ),
        );
  }

  Container _resourceCardWidget(String image, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorResources.gray,
        image: DecorationImage(
            image: NetworkImage(image), fit: BoxFit.cover, opacity: 0.6),
        gradient: const LinearGradient(colors: [
          Colors.white,
          Colors.black,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          text,
          style: TextStyle(
              color: ColorResources.textWhite, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
