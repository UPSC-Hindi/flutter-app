import 'package:cached_network_image/cached_network_image.dart';
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
                    SizedBox(
                      height: 60,
                      child: CachedNetworkImage(
                        imageUrl: SvgImages.aboutLogo,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                    'UPSC HINDI एक उत्कृष्ट शैक्षणिक संस्थान है जिसका उद्देश्य विशेष तौर पर सिविल सेवा परीक्षा में क्रांति लाना है। UPSC HINDI अपने ध्येय वाक्य “सिद्धिर्भवति कर्मजा” को श्रीमद्भागवतगीता से ग्रहण करता है एवं इसके सार को छात्रों के मध्य प्रसारित करता है कि “अभ्यास से ही सफलता प्राप्त होती है।” \n\nUPSC HINDI वर्तमान में संघ लोक सेवा आयोग एवं राज्य लोक सेवा आयोग के क्षेत्र में कार्य कर रहा है। भविष्य में UPSC HINDI अन्य सभी परीक्षाओं के लिए भी विद्यार्थियों को वहनीय, गुणवत्तापूर्ण एवं प्रभावी शिक्षण के साथ मार्गदर्शन उपलब्ध कराने हेतु प्रयासरत है। \n\n#AffordableEducation\n\nUPSC HINDI टीम बेहद अनुभवी एवं सफल है जिसके साथ अभी तक बहुत से अभ्यर्थियों ने अपने लक्ष्य को प्राप्त किया है। \n\nसंस्थापक: \n\nगौरव कुमार त्रिपाठी (02 IAS INTERVIEW, UPPSC 2020 SELECTED, IIT R)'
                    '\n\nसत्यप्रकाश त्रिपाठी (MA (हिन्दी), NET)\n\nरमन दीप (IIT DHN)\n\nनिशांत त्रिपाठी (PCS विशेषज्ञ)\n\nपल्लव (MMMUT)',
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
