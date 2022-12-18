import 'package:flutter/material.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContainerWidget extends StatelessWidget {
  const ContactContainerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: ColorResources.gray),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.network(
              SvgImages.email,
              height: 40,
            ),
            const SizedBox(height: 10),
            Text(
              Languages.emailText,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri(
                  scheme: 'mailto',
                  path: 'upschindi4cse@gmail.com',
                  query: 'subject=helpandsupport&body=msg',
                ));
              },
              child: Text(
                'info@upschindi.online',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              Languages.phoneText,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("tel:+919519780078"));
              },
              child: Text(
                '+91  951 978 0078',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://www.wa.me/+919519780078"),
                    mode: LaunchMode.externalApplication);
              },
              child: Image.network(SvgImages.whatsapp),
            ),
            Text(Languages.whatsApp),
            const SizedBox(height: 20),
            Container(
              width: double.infinity * 0.40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse("https://www.facebook.com/UPSCHINDI4CSE"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.network(
                      SvgImages.facebook,
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("https://twitter.com/upschindi4cse"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.network(
                      SvgImages.twitter,
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse("https://www.instagram.com/upschindi4cse"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.network(
                      SvgImages.linkedin,
                      height: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
