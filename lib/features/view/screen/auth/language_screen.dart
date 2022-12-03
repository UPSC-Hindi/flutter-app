import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/langauge.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);
  int selected = 0;
  int selected_course = 0;
  int Lcount = 0;
  int Ccount = 0;
  List streamlist = [];
  List<String> SelectedStream = [];
  bool isSelectedChip = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        constraints: const BoxConstraints(maxWidth: 375),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  'Choose Your Medium',
                  style: GoogleFonts.notoSansDevanagari(
                      fontSize: 30, color: ColorResources.textblack),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customRadio('English', 'A', 1, true, context),
                customRadio('Hindi', 'अ', 2, true, context),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  'Select Your Stream',
                  style: GoogleFonts.notoSansDevanagari(
                      fontSize: 30, color: ColorResources.textblack),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              children: _buildChoiceList(),
            ),
            const SizedBox(
              height: 100,
            ),
            Lcount > 0 && Ccount > 0
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextButton(
                      onPressed: () async {
                        PreferencesHelper.setString(Preferences.language,
                            selected == 2 ? 'Hindi' : 'English');
                        PreferencesHelper.setStringList(
                            Preferences.course, SelectedStream);
                        // List<String>? dummy = await SharedPreferenceHelper.getStringList(Preferences.course);

                        var token =
                            PreferencesHelper.getString(Preferences.authToken);
                        //todo:add the route as u need
                        // PreferencesHelper.updateLanguage(
                        //     selected == 2 ? 'hi' : 'en', token!);
                        // PreferencesHelper.updateStream(SelectedStream);

                        // if (widget.isLogin) {
                        //   Languages.isEnglish =
                        //       selected == 2 ? false : true;
                        //   Languages.initState();
                        //   Navigator.popUntil(context, (route) => false);
                        //   Navigator.pushNamed(context, 'home');
                        // } else {
                        //   Fluttertoast.showToast(
                        //     msg: 'Successful Register',
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.BOTTOM,
                        //     backgroundColor: ColorResources.gray,
                        //     textColor: ColorResources.textWhite,
                        //   );
                        //   Navigator.popUntil(
                        //       context, ModalRoute.withName('SignIn'));
                        //   Navigator.pushNamed(context, 'home');
                        // }
                      },
                      child: Text(
                        'Save & Continue',
                        style: GoogleFonts.notoSansDevanagari(
                            color: ColorResources.textWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                : const Text(''),
          ],
        ),
      )),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    streamlist.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Colors.transparent,
          selectedColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: SelectedStream.contains(element)
                    ? ColorResources.buttoncolor
                    : ColorResources.gray.withOpacity(0.5),
              )),
          labelStyle: GoogleFonts.notoSansDevanagari(
              fontSize: 30, fontWeight: FontWeight.bold),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectedStream.contains(element)
                  ? Icon(Icons.check_circle, color: ColorResources.buttoncolor)
                  : const Text(''),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(element),
              ),
            ],
          ),
          selected: SelectedStream.contains(element),
          onSelected: (value) {
            SelectedStream.contains(element)
                ? SelectedStream.remove(element)
                : SelectedStream.add(element);
            SelectedStream.length > 0 ? Ccount = Ccount + 1 : Ccount = 0;
            print(SelectedStream);
          },
        ),
      ));
    });
    return choices;
  }

  Widget customRadio(
      String text, String src, int index, bool tick, BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          width: 2,
          style: BorderStyle.solid,
          color: true
              ? ColorResources.buttoncolor
              : ColorResources.gray.withOpacity(0.5),
        ),
      ),
      onPressed: () {
        // TODO : dinesh create this thing using cubit
        // setState(() {
        //   selected = index;
        //   Lcount = Lcount + 1;
        // });
      },
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: 100,
              child: Column(children: [
                Text(
                  src,
                  style: GoogleFonts.notoSansDevanagari(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                //SizedBox(height: 60, child: SvgPicture.asset(src)),
                Text(
                  text,
                  style: GoogleFonts.notoSansDevanagari(
                      color: Colors.black, fontSize: 12),
                ),
              ]),
            ),
            // selected == index
            true
                ? const Positioned(
                    top: 5,
                    left: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFFF05266),
                    ))
                : const Text('')
          ],
        ),
      ),
    );
  }
}
