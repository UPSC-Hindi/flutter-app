import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/view/screens/bottomnav/ncert.dart';

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
            child: _resourceCardWidget(SvgImages.dailyNews, 'Daily News'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('courseIndex'),
            child: _resourceCardWidget(SvgImages.courseIndex, 'Course Index'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('shortnotes'),
            child: _resourceCardWidget(SvgImages.shortNotes, 'Short Notes'),
          ),
          GestureDetector(
            //onTap: () => Navigator.of(context).pushNamed('youtubenotes'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NcertScreen(
                from: 'note',
              ),
            )),
            child: _resourceCardWidget(SvgImages.youtubeNotes, 'Youtube Note'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('samplenotes'),
            child: _resourceCardWidget(SvgImages.sampleNotes, 'Sample Notes'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('airResources'),
            child: _resourceCardWidget(SvgImages.sampleNotes, 'Air'),
          ),
        ],
      ),
    );
  }

  Widget _resourceCardWidget(String image, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorResources.gray, width: 1),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: ColorResources.resourcesCardColor.withOpacity(0.4),
                child: Image.asset('assets/images/dailyNews.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: ColorResources.textblack,
                    fontWeight: FontWeight.w800,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
