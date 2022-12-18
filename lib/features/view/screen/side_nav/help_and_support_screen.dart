import 'package:flutter/material.dart';
import 'package:upsc_web/features/view/widget/contact_container_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(Languages.helpAndSupport,
            style: Theme.of(context).textTheme.headline1),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            Languages.freeMessage,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 30,
          ),
          ContactContainerWidget()
        ],
      ),
    );
  }
}
