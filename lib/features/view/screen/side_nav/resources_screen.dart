import 'package:flutter/material.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/controller/resource_controller.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);
  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  ResourceController resourceController = ResourceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.textWhite,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        title: Text(
          //'Resources'
          Languages.resources,
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
            onTap: () => Navigator.of(context)
                .pushNamed(AppRoute.dailyNews, arguments: resourceController),
            child: _resourceCardWidget(SvgImages.dailyNews, 'Daily News'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('courseIndex'),
            child: _resourceCardWidget(
                SvgImages.courseIndex, Languages.Course_Index),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoute.shortNotes),
            child: _resourceCardWidget(SvgImages.shortNotes, 'Short Notes'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoute.youtubeNotes);
            },
            child: _resourceCardWidget(SvgImages.youtubeNotes, 'Youtube Note'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoute.sampleNotes),
            child: _resourceCardWidget(SvgImages.sampleNotes, 'Sample Notes'),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoute.airResources),
            child: _resourceCardWidget(SvgImages.air, 'Air'),
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
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: ColorResources.resourcesCardColor.withOpacity(0.4),
                child: Image.network(image),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(text, style: Theme.of(context).textTheme.headline2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
