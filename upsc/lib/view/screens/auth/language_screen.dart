import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/features/controller/auth_controller.dart';
import 'package:upsc/features/cubit/auth/auth_cubit.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/screens/home.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selected = 5;
  List streamList = [];
  List<String> selectedStream = [];
  bool isSelectedChip = false;
  late Future<List<String>> getStream;
  AuthController authController = AuthController();
  @override
  void initState() {
    getStream = authController.getStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateLanguageStreamSuccess) {
          Navigator.popUntil(context, (route) => false);
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>HomeScreen()
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is LoadingAuth) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
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
                    customRadio(
                      'English',
                      'A',
                      0,
                      true,
                    ),
                    customRadio(
                      'Hindi',
                      'अ',
                      1,
                      true,
                    ),
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
                FutureBuilder<List<String>>(
                    future: getStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          streamList = snapshot.data!;
                          return Wrap(
                            children: _buildChoiceList(),
                          );
                        } else {
                          return const Text("Refresh Screen or check Internet");
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                const SizedBox(
                  height: 100,
                ),
                selectedStream.isNotEmpty && selected < 2
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context)
                                .updateStreamLanguage(
                                    language: selected == 0 ? 'en' : 'hi',
                                    stream: selectedStream);
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
      },
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    streamList.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Colors.transparent,
          selectedColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: selectedStream.contains(element)
                    ? ColorResources.buttoncolor
                    : ColorResources.gray.withOpacity(0.5),
              )),
          labelStyle: GoogleFonts.notoSansDevanagari(
              fontSize: 30, fontWeight: FontWeight.bold),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              selectedStream.contains(element)
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
          selected: selectedStream.contains(element),
          onSelected: (value) {
            selectedStream.contains(element)
                ? selectedStream.remove(element)
                : selectedStream.add(element);
            setState(() {
              selectedStream;
            });
          },
        ),
      ));
    });
    return choices;
  }

  Widget customRadio(String text, String src, int index, bool tick) {
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
        });
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
}
