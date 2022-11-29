import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  void initState() {
    super.initState();
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
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: const Text(
                      'Choose your preferred Medium',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customRadio('English', 'A', 1, true),
                    customRadio('Hindi', 'अ', 2, true),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: const Text(
                      'Select your stream',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customRadio_course('', 'IAS', 3, true),
                    customRadio_course('', 'PCS', 4, true),
                  ],
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
                          onPressed: () {
                            AuthDataSourceImpl authDataSourceImpl =
                                AuthDataSourceImpl();

                            SharedPreferenceHelper.setString(
                                Preferences.language,
                                selected == 2 ? 'Hindi' : 'English');
                            SharedPreferenceHelper.setString(Preferences.course,
                                selected_course == 3 ? 'IAS' : 'PCS');

                            var token = SharedPreferenceHelper.getString(
                                Preferences.auth_token);
                            authDataSourceImpl.updateLanguage(
                                selected == 2 ? 'hi' : 'en', token!);
                            authDataSourceImpl.updateStream(
                                selected_course == 3 ? 'IAS' : 'PCS', token);

                            if (widget.isLogin) {
                              Languages.isEnglish = selected == 2 ? false : true;
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
                            style: TextStyle(
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

  Widget customRadio(String text, String src, int index, bool tick) {
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
          selected = index;
          Lcount = Lcount + 1;
        });
      },
      child: Container(
        width: 90,
        height: 130,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Text(
                  src,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.w800),
                ),
                //SizedBox(height: 60, child: SvgPicture.asset(src)),
                Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ]),
            ),
            selected == index
                ? const Positioned(
                    top: 3,
                    left: -1,
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
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  //SizedBox(height: 60, child: SvgPicture.asset(src)),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.black),
                  ),
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