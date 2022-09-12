import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selected = 0;

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
                  child: Container(
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
                    customRadio('English', SvgImages.EnglishA, 1, true),
                    customRadio('Hindi', SvgImages.HindA, 2, true),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
                selected != 0
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('login'));
                            Navigator.of(context).pushNamed('home');
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
                    : Text(''),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60, child: SvgPicture.asset(src)),
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
}
