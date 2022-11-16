import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/view/screens/contactus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorResources.textWhite),
        backgroundColor: ColorResources.buttoncolor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            CustomPaint(
              painter: MyPainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Column(
                  children: [
                    Image.asset(
                      SvgImages.logo,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'About US',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        color: ColorResources.textWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'जो भी अभ्यर्थी हमारे साथ paid courses में शामिल हैं ,हम उनके साथ समय- समय पर \n \n zoom , Google meet के ज़रिए जुड़ते है और वो भी एक परिवार की भाँति सुझाव देते है कि किस प्रकार UPSC हिन्दी को और बेहतर बनाया जा सकता है ।\n \n  –UPSC हिन्दी का अन्य किसी भी YouTube चैनल से view/subscriber ratio ज़्यादा है , जो की हमारे प्रति लोगों के भरोसे को प्रदर्शित करता है ।\n \n –हमारी टीम में स्वयं ASPIRANT है जिससे हम परीक्षा की गतिशीलता के अनुसार रणनीति में ज़रूरी बदलाव करते रहते है, और ट्रेंड्स को पकड़े रहते हैं ,जो की किसी भी अन्य संस्थान (जो निर्धारित ढर्रे पर चले जा रहे हैं) के विपरीत है ।',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      launchUrl(
                          Uri.parse(
                              "https://upschindi.in/%e0%a4%aa%e0%a5%8d%e0%a4%b0%e0%a4%be%e0%a4%b0%e0%a4%ae%e0%a5%8d%e0%a4%ad%e0%a4%bf%e0%a4%95-%e0%a4%aa%e0%a4%b0%e0%a5%80%e0%a4%95%e0%a5%8d%e0%a4%b7%e0%a4%be/upsc-%e0%a4%b9%e0%a4%bf%e0%a4%a8%e0%a5%8d%e0%a4%a6%e0%a5%80-%e0%a4%95%e0%a5%8d%e0%a4%af%e0%a5%8b%e0%a4%82/"),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Text('Know more...'))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
