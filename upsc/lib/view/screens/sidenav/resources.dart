import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);
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
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          padding: EdgeInsets.all(10),
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('dailynews'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorResources.gray,
                ),
                child: Center(
                  child: Text(
                    'Daily News',
                    style: TextStyle(color: ColorResources.textWhite),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorResources.gray,
                ),
                child: Center(
                  child: Text(
                    'Course Index',
                    style: TextStyle(color: ColorResources.textWhite),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('shortnotes'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorResources.gray,
                ),
                child: Center(
                  child: Text(
                    'Short Notes',
                    style: TextStyle(color: ColorResources.textWhite),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('youtubenotes'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorResources.gray,
                ),
                child: Center(
                  child: Text(
                    'YouTube Notes',
                    style: TextStyle(color: ColorResources.textWhite),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('samplenotes'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorResources.gray,
                ),
                child: Center(
                  child: Text(
                    'Sample Notes',
                    style: TextStyle(color: ColorResources.textWhite),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
