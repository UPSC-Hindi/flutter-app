import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/GoogleSignIn.dart';
import 'package:upsc/models/auth/login_model.dart';
import 'package:upsc/models/banner.dart';
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
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _passwordVisible = true;
  static String? deviceConfig;
  static String? deviceName;
  List<Widget> images = [];
  googleauth.GoogleSignInAccount? result;

  @override
  void initState() {
    callApigetbanner();
    getdevices();
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

  Future getdevices() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      deviceName = androidInfo.brand;
      deviceConfig = androidInfo.id;
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
      if (result!.email.isNotEmpty) {
        callApigooglelogin();
        //await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CarouselSlider(
                items: images,
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
            ),
            FractionallySizedBox(
              widthFactor: 0.80,
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.textblack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        validator:
                            ValidationBuilder().required().email().build(),
                        controller: emailController,
                        style: GoogleFonts.notoSansDevanagari(fontSize: 20),
                        onChanged: ((value) {
                          _form.currentState!.validate();
                        }),
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
                      child: TextFormField(
                        validator: ValidationBuilder()
                            .required()
                            .minLength(8)
                            .regExp(
                                RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                                'valid password ex:Testing@1')
                            .maxLength(50)
                            .build(),
                        onChanged: ((value) {
                          _form.currentState!.validate();
                        }),
                        obscureText: _passwordVisible,
                        controller: passwordController,
                        style: GoogleFonts.notoSansDevanagari(fontSize: 20),
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
                          style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.buttoncolor),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('forgotpasswordscreen');
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width * 0.60,
                      decoration: BoxDecoration(
                          color: ColorResources.buttoncolor,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            callApilogin();
                          } else {
                            flutterToast('pls enter all required fields');
                          }
                          //Navigator.of(context).pushReplacementNamed('home');
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.notoSansDevanagari(
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
                      height: 30,
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
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create an account?',
                          style: GoogleFonts.notoSansDevanagari(),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('SignUp');
                            },
                            child: Text(
                              ' Register',
                              style: GoogleFonts.notoSansDevanagari(
                                color: ColorResources.buttoncolor,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        //Navigator.of(context).popUntil((route) => route.isFirst);
        if (response.data != null) {
          await SharedPreferenceHelper.setString(
              Preferences.access_token, response.data!.accessToken);
          await SharedPreferenceHelper.setBoolean(
              Preferences.is_logged_in, true);
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
          await SharedPreferenceHelper.setString(
            Preferences.profileImage,
            response.data!.profilePhoto,
          );
          await SharedPreferenceHelper.setString(
              Preferences.userid, response.data!.userID);
          await SharedPreferenceHelper.setString(
              Preferences.address, response.data!.address);

          print(SharedPreferenceHelper.getString(Preferences.access_token)
                  .toString() +
              '*' * 200);
          Navigator.of(context).pushNamed('home');
        }
        print(SharedPreferenceHelper.getString(Preferences.access_token));
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
      "usernameFromGoogle": result!.displayName,
      "deviceConfig": deviceConfig,
      "deviceName": deviceName,
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response =
          await RestClient(RetroApi2().dioData2()).googleSigninRequest(body);
      if (response.status!) {
        setState(() {
          Preferences.hideDialog(context);
        });
        if (response.data == null) {
          Fluttertoast.showToast(
            msg: '${response.msg}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorResources.gray,
            textColor: ColorResources.textWhite,
          );
        } else {
          if (response.data!.userMobileNumberVerified!) {
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
            Languages.isEnglish =
                response.data!.language == "hi" ? false : true;
            await SharedPreferenceHelper.setString(
                Preferences.profileImage, response.data!.profilePhoto);
            await SharedPreferenceHelper.setString(
                Preferences.address, response.data!.address);
            Navigator.of(context).pushNamed('home');
            Fluttertoast.showToast(
              msg: '${response.msg}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ColorResources.gray,
              textColor: ColorResources.textWhite,
            );
          } else {
            await SharedPreferenceHelper.setString(
                Preferences.name, response.data!.fullName);
            await SharedPreferenceHelper.setString(
                Preferences.email, response.data!.email);
            await SharedPreferenceHelper.setString(
                Preferences.auth_token, response.data!.verificationToken);
            await SharedPreferenceHelper.setString(
                Preferences.profileImage, response.data!.profilePhoto);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MobileVerification(),
              ),
            );
            print(SharedPreferenceHelper.getString(Preferences.access_token));
            Fluttertoast.showToast(
              msg: '${response.msg}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ColorResources.gray,
              textColor: ColorResources.textWhite,
            );
          }
        }
        // await SharedPreferenceHelper.setString(Preferences.language,
        //     response.data!.language == "hi" ? "Hindi" : 'English');
        // Languages.isEnglish = response.data!.language == "hi" ? false : true;
        //await Languages.initState();
        //Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        setState(() {
          Preferences.hideDialog(context);
        });
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
