import 'package:flutter/material.dart';
import 'package:upsc_web/features/view/widget/contact_container_widget.dart';
import 'package:upsc_web/features/view/widget/my_painter.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Size get preferredSize => const Size.fromHeight(400.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            CustomPaint(
              painter: MyPainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.textWhite,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.network(
                      SvgImages.aboutLogo,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'We’re here to Solve',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
                Text(
                  'Feel free to reach us on',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: 30,
                ),
                ContactContainerWidget(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
