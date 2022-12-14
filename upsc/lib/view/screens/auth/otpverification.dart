import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/VerifyMobileNumber.dart';
import 'package:upsc/models/auth/resendotp.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/languagescreen.dart';

class Otpverification extends StatefulWidget {
  String? number;
  Otpverification({Key? key, required this.number}) : super(key: key);

  @override
  State<Otpverification> createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? phonenumber, otp;
  List<Widget> images = [];

  var token;

  @override
  void initState() {
    phonenumber = widget.number;
    callApigetbanner();
    super.initState();
  }

  Future<BaseModel<getbannerdetails>> callApigetbanner() async {
    getbannerdetails response;
    try {
      response = await RestClient(RetroApi2().dioData2()).bannerimagesRequest();
      print(response.msg);
      for (var entry in response.data!) {
        for (String image in entry.bannerUrl!) {
          print(image);
          images.add(Image.network(image));
        }
      }
      setState(() {});
      print(images);
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: images,
                // [
                //   Image.network(SvgImages.banner_1,),
                //   Image.network(SvgImages.banner_2,),
                //   Image.network(SvgImages.banner_3,),
                //   Image.network(SvgImages.banner_4,),
                // ],
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
                widthFactor: 0.90,
                child: Column(
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
                        '+91 $phonenumber Change',
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
                        setState(() {
                          otp = pin;
                        });
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
                        onPressed: () {
                          callApiVerifyMobileNumber();
                          //Navigator.of(context).popAndPushNamed('languagescreen');
                        },
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
                          onPressed: () {
                            callApiresendotp();
                            //Navigator.of(context).popAndPushNamed('SignIn');
                          },
                          child: Text(
                            ' Try again',
                            style: GoogleFonts.notoSansDevanagari(color: ColorResources.buttoncolor),
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
      ),
    );
  }

  Future<BaseModel<VerifyMobileNumber>> callApiVerifyMobileNumber() async {
    VerifyMobileNumber response;
    Map<String, dynamic> body = {
      "otp": otp,
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      token =
          SharedPreferenceHelper.getString(Preferences.auth_token).toString();
      response = await RestClient(RetroApi().dioData(token))
          .verifymobilenumberRequest(body);
      setState(() {
        Preferences.hideDialog(context);
        print(response.msg);
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      });
      if (response.status!) {
        await SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
        await SharedPreferenceHelper.setString(
            Preferences.phoneNUmber, widget.number);
        SharedPreferenceHelper.setString(
            Preferences.access_token, response.data!.accessToken!);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(isLogin: false),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<Resendotp>> callApiresendotp() async {
    Resendotp response;
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      token =
          SharedPreferenceHelper.getString(Preferences.auth_token).toString();
      response = await RestClient(RetroApi().dioData(token)).resendotpRequest();
      setState(() {
        Preferences.hideDialog(context);
      });
      print('*' * 200);
      print(response.msg);
      if (response.status!) {
        Fluttertoast.showToast(
          msg: '${response.data!.mobileNumberVerificationOTP}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
