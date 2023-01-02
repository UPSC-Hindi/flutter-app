import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:upsc/features/cubit/auth/auth_cubit.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/view/screens/auth/language_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    Key? key,
    required this.bannerList,
    required this.userNumber,
  }) : super(key: key);
  final List<Widget> bannerList;
  final String userNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;
  String otp = '';

  final length = 4;
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: GoogleFonts.notoSansDevanagari(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {

    final controller = TextEditingController();
    final focusNode = FocusNode();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationOtpSuccess) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>LanguageScreen()
              ),
            );
        }
      },
      builder: (context, state) {
        if (State is LoadingAuth) {
          return const CircularProgressIndicator();
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    items: widget.bannerList,
                    options: CarouselOptions(
                      height: 250,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'OTP sent on',
                        style: GoogleFonts.notoSansDevanagari(
                            color: ColorResources.textblack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '+91 ${widget.userNumber} Change',
                          style: GoogleFonts.notoSansDevanagari(fontSize: 20),
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
                          otp = pin;
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
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: _verifyButton,
                          child: Text(
                            'Verify',
                            style: GoogleFonts.notoSansDevanagari(
                                color: ColorResources.textWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Did not recieve the code?'),
                          TextButton(
                            onPressed: _resendOtp,
                            child: Text(
                              ' Try again',
                              style: GoogleFonts.notoSansDevanagari(
                                  color: ColorResources.buttoncolor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _verifyButton() {
    BlocProvider.of<AuthCubit>(context).verifyOtp(otp);
  }

  void _resendOtp() {
    BlocProvider.of<AuthCubit>(context).resendOtp();
  }
}
