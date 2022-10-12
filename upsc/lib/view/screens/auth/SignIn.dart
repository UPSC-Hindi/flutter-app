import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/GoogleSignIn.dart';
import 'package:upsc/models/auth/login_model.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:upsc/view/screens/auth/mobile_verification.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _passwordVisible = true;
  static String? deviceConfig;
  static String? deviceName;

  googleauth.GoogleSignInAccount? result;

  @override
  void initState() {
    getdevices();
    super.initState();
  }

  Future getdevices() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      deviceName = androidInfo.brand;
      deviceConfig = androidInfo.androidId;
      print('Running on ${androidInfo.type}');
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  googleLogin() async {
    try {
      print("googleLogin method Called");
      final _googleSignIn = googleauth.GoogleSignIn();
      result = await _googleSignIn.signIn();
      print("Result $result");
      print("Result ${result!.authHeaders}");
      print("Result ${result!.displayName}");
      print("Result ${result!.email}");
      print("Result ${result!.photoUrl}");
      print("Result ${result!.authentication}");
      if (result!.email != null) {
        callApigooglelogin();
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Image.network(
                    SvgImages.banner_1,
                  ), // SvgPicture.asset(SvgImages.banner_1,),
                  Image.network(SvgImages
                      .banner_2), // SvgPicture.asset(SvgImages.banner_2),
                  Image.network(SvgImages
                      .banner_3), // SvgPicture.asset(SvgImages.banner_3),
                  Image.network(SvgImages.banner_4),
                  // SvgPicture.asset(SvgImages.banner_4),
                ],
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
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
              FractionallySizedBox(
                widthFactor: 0.80,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: ColorResources.textblack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Email Id',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        obscureText: _passwordVisible,
                        controller: passwordController,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorResources.gray,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          "Forgot password?",
                          style: GoogleFonts.poppins(
                              color: ColorResources.buttoncolor),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('forgotpasswordscreen');
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      decoration: BoxDecoration(
                          color: ColorResources.buttoncolor,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextButton(
                        onPressed: () {
                          callApilogin();
                          //Navigator.of(context).pushReplacementNamed('home');
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              color: ColorResources.textWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                        Text(
                          "Or Sign in with",
                          style: GoogleFonts.lato(),
                        ),
                        const Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            googleLogin();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.network(SvgImages.google),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: SvgPicture.network(SvgImages.apple),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create an account?',
                          style: GoogleFonts.poppins(),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('SignUp');
                            },
                            child: Text(
                              ' Register',
                              style: GoogleFonts.poppins(
                                color: ColorResources.buttoncolor,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<BaseModel<Login>> callApilogin() async {
    Login response;
    Map<String, dynamic> body = {
      "email_phoneNumber": emailController.text,
      "password": passwordController.text,
      "deviceConfig": deviceConfig,
      "deviceName": deviceName
    };

    setState(() {
      Preferences.onLoading(context);
    });

    try {
      response = await RestClient(RetroApi2().dioData2()).loginRequest(body);
      setState(() {
        Preferences.hideDialog(context);
      });
      if (response.status!) {
        await SharedPreferenceHelper.setString(
            Preferences.access_token, response.data!.accessToken);
        await SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
        await SharedPreferenceHelper.setString(Preferences.language,
            response.data!.language == "hi" ? "Hindi" : 'English');
        Languages.isEnglish = response.data!.language == "hi" ? false : true;
        await Languages.initState();
        await SharedPreferenceHelper.setString(
            Preferences.name, response.data!.fullName);
        await SharedPreferenceHelper.setString(
            Preferences.phoneNUmber, response.data!.phoneNumber);
        await SharedPreferenceHelper.setString(
            Preferences.email, response.data!.email);

        print(await SharedPreferenceHelper.getString(Preferences.access_token)
                .toString() +
            '*' * 200);
        //Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed('home');
        print(SharedPreferenceHelper.getString(Preferences.access_token));
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

  Future<BaseModel<GoogleSignIn>> callApigooglelogin() async {
    GoogleSignIn response;
    print("*123" * 200);
    Map<String, dynamic> body = {
      "email": result!.email,
      "profilePhoto": result!.photoUrl,
      "FullName": result!.displayName,
      "deviceConfig": deviceConfig,
      "deviceName": deviceName,
    };

    try {
      response =
          await RestClient(RetroApi2().dioData2()).googleSigninRequest(body);
      if (response.status!) {
        if (response.data!.verified!) {
          await SharedPreferenceHelper.setString(
              Preferences.access_token, response.data!.accessToken);
          await SharedPreferenceHelper.setBoolean(
              Preferences.is_logged_in, true);
          await SharedPreferenceHelper.setString(
              Preferences.name, response.data!.fullName);
          await SharedPreferenceHelper.setString(
              Preferences.email, response.data!.email);
          await SharedPreferenceHelper.setString(
              Preferences.phoneNUmber, response.data!.phoneNumber);
          await SharedPreferenceHelper.setString(Preferences.language,
              response.data!.language == "hi" ? "Hindi" : 'English');
          Languages.isEnglish = response.data!.language == "hi" ? false : true;

          Navigator.of(context).pushNamed('home');
        } else {
          await SharedPreferenceHelper.setString(
              Preferences.name, response.data!.fullName);
          await SharedPreferenceHelper.setString(
              Preferences.email, response.data!.email);
          await SharedPreferenceHelper.setString(
              Preferences.auth_token, response.data!.verificationToken);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MobileVerification(),
            ),
          );
        }
        // await SharedPreferenceHelper.setString(Preferences.language,
        //     response.data!.language == "hi" ? "Hindi" : 'English');
        // Languages.isEnglish = response.data!.language == "hi" ? false : true;
        //await Languages.initState();
        //Navigator.of(context).popUntil((route) => route.isFirst);
        print(SharedPreferenceHelper.getString(Preferences.access_token));
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
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
