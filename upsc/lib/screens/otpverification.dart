import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:upsc/util/color_resources.dart';

class Otpverification extends StatefulWidget {
  const Otpverification({Key? key}) : super(key: key);

  @override
  State<Otpverification> createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  final length = 4;
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: const Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset('assets/images/ad 1.jpg'),
                Image.asset('assets/images/ad 2.jpg'),
                Image.asset('assets/images/ad 3.jpg'),
                Image.asset('assets/images/ad 4.jpg'),
              ],
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.80,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'OTP sent on',
                    style: TextStyle(
                        color: ColorResources.textblack,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      '+91 9999999999' + ' Change',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    length: length,
                    controller: controller,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      setState(() => showError = pin != '5555');
                    },
                    focusedPinTheme: defaultPinTheme.copyWith(
                      height: 68,
                      width: 64,
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: borderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('languagescreen');
                      },
                      child: Text(
                        'Verify',
                        style: TextStyle(
                            color: ColorResources.textWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Did not recieve the code?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('SignIn');
                        },
                        child: Text(
                          ' Try again',
                          style: TextStyle(color: ColorResources.buttoncolor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
