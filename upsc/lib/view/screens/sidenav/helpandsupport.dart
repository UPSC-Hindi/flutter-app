import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        title: Text(
          Languages.helpAndSupport,
          style:
              GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            Languages.freeMessage,
            style: GoogleFonts.notoSansDevanagari(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
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
                    style: GoogleFonts.notoSansDevanagari(
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri(
                        scheme: 'mailto',
                        path: 'info@upschindi.online',
                        query: 'subject=helpandsupport&body=msg',
                      ));
                    },
                    child: Text(
                      'info@upschindi.online',
                      style: GoogleFonts.notoSansDevanagari(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Languages.phoneText,
                    style: GoogleFonts.notoSansDevanagari(
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("tel:+919519780078"));
                    },
                    child: Text(
                      '+91  951 978 0078',
                      style: GoogleFonts.notoSansDevanagari(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("https://www.wa.me/+919519780078"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: CachedNetworkImage(
                      imageUrl: SvgImages.whatsapp,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
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
                                Uri.parse(
                                    "https://www.facebook.com/UPSCHINDI4CSE"),
                                mode: LaunchMode.externalApplication);
                          },
                          child: CachedNetworkImage(
                            imageUrl: SvgImages.facebook,
                            height: 30,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(
                                Uri.parse("https://twitter.com/upschindi4cse"),
                                mode: LaunchMode.externalApplication);
                          },
                          child: CachedNetworkImage(
                            imageUrl: SvgImages.twitter,
                            height: 30,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(
                                Uri.parse(
                                    "https://www.instagram.com/upschindi4cse"),
                                mode: LaunchMode.externalApplication);
                          },
                          child: CachedNetworkImage(
                            imageUrl: SvgImages.linkedin,
                            height: 30,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
