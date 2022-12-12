import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/postUserMobileNumber.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/otpverification.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final TextEditingController _numberController = TextEditingController();
  List<Widget> images = [];
  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            items: images,
            // [
            //   Image.network(
            //     SvgImages.banner_1,
            //   ), // SvgPicture.asset(SvgImages.banner_1,),
            //   Image.network(
            //       SvgImages.banner_2), // SvgPicture.asset(SvgImages.banner_2),
            //   Image.network(
            //       SvgImages.banner_3), // SvgPicture.asset(SvgImages.banner_3),
            //   Image.network(SvgImages.banner_4),
            //   // SvgPicture.asset(SvgImages.banner_4),
            // ],
            options: CarouselOptions(
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Verify Your Phone Number',
            style: GoogleFonts.notoSansDevanagari(
                fontWeight: FontWeight.w900, fontSize: 24),
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: TextField(
              controller: _numberController,
              style: GoogleFonts.notoSansDevanagari(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Mobile Number',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.50,
            margin: const EdgeInsets.symmetric(vertical: 35),
            decoration: BoxDecoration(
                color: ColorResources.buttoncolor,
                borderRadius: BorderRadius.circular(14)),
            child: TextButton(
              onPressed: () {
                callApinumberverif();
              },
              child: Text(
                'Send OTP',
                style: GoogleFonts.notoSansDevanagari(
                    color: ColorResources.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<BaseModel<postUserMobileNumber>> callApinumberverif() async {
    postUserMobileNumber response;
    Map<String, dynamic> body = {
      "userMobileNumber": _numberController.text,
    };

    setState(() {
      Preferences.onLoading(context);
    });

    try {
      String? token = SharedPreferenceHelper.getString(Preferences.auth_token);
      response = await RestClient(RetroApi().dioData(token!))
          .postUserMobileNumberRequest(body);
      setState(() {
        Preferences.hideDialog(context);
      });
      if (response.status!) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) =>
                Otpverification(number: _numberController.text)),
          ),
        );
        Fluttertoast.showToast(
          msg: '${response.data![0].mobileNumberVerificationOTP}',
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
