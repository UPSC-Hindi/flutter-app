import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/data/remote/data_sources/auth/auth_data_source_impl.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selected = 0;
  int selected_course = 0;
  int Lcount = 0;
  int Ccount = 0;
  List streamlist = [];
  List<String> SelectedStream = [];
  bool isSelectedChip = false;
  AuthDataSourceImpl authDataSourceImpl = AuthDataSourceImpl();

  @override
  void initState() {
    getStream();
    super.initState();
  }

  void getStream() async {
    streamlist = await authDataSourceImpl.getStream();
    setState(() {
      streamlist;
    });
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
            setState(() {
              SelectedStream.contains(element)
                  ? SelectedStream.remove(element)
                  : SelectedStream.add(element);
              SelectedStream.length > 0 ? Ccount = Ccount + 1 : Ccount = 0;
              print(SelectedStream);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     customRadio_course('', 'IAS', 3, true),
                //     customRadio_course('', 'PCS', 4, true),
                //   ],
                // ),
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
                            SharedPreferenceHelper.setString(
                                Preferences.language,
                                selected == 2 ? 'Hindi' : 'English');
                            SharedPreferenceHelper.setStringList(
                                Preferences.course, SelectedStream);
                            // List<String>? dummy = await SharedPreferenceHelper.getStringList(Preferences.course);

                            var token = SharedPreferenceHelper.getString(
                                Preferences.auth_token);
                            authDataSourceImpl.updateLanguage(
                                selected == 2 ? 'hi' : 'en', token!);
                            authDataSourceImpl.updateStream(SelectedStream);

                            if (widget.isLogin) {
                              Languages.isEnglish =
                                  selected == 2 ? false : true;
                              Languages.initState();
                              Navigator.popUntil(context, (route) => false);
                              Navigator.pushNamed(context, 'home');
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Successful Register',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ColorResources.gray,
                                textColor: ColorResources.textWhite,
                              );
                              Navigator.popUntil(
                                  context, ModalRoute.withName('SignIn'));
                              Navigator.pushNamed(context, 'home');
                            }
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
            )
          ],
        ),
      ),
    );
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
          color: selected == index
              ? ColorResources.buttoncolor
              : ColorResources.gray.withOpacity(0.5),
        ),
      ),
      onPressed: () {
        setState(() {
          selected = index;
          Lcount = Lcount + 1;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.width * 0.22,
              child: Column(children: [
                index == 1
                    ? Padding(
                        padding: const EdgeInsets.only(),
                        child: Text(
                          src,
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 40,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Text(
                          src,
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 40,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                //SizedBox(height: 60, child: SvgPicture.asset(src)),
                Text(
                  text,
                  style: GoogleFonts.notoSansDevanagari(
                      color: Colors.black, fontSize: 12),
                ),
              ]),
            ),
            selected == index
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

  Widget customRadio_course(String text, String src, int index, bool tick) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          selected_course = index;
          Ccount = Ccount + 1;
        });
      },
      child: Container(
        width: 100,
        height: 130,
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    src,
                    style: GoogleFonts.notoSansDevanagari(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  //SizedBox(height: 60, child: SvgPicture.asset(src)),
                ]),
            selected_course == index
                ? const Positioned(
                    top: 3,
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
