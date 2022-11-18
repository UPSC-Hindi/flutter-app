import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/models/GoogleSignIn.dart';
import 'package:upsc/models/auth/register.dart';
import 'package:upsc/models/banner.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/mobile_verification.dart';
import 'package:upsc/view/screens/auth/otpverification.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<Widget> images = [];
  bool _passwordVisible = true;
  static String? deviceConfig;
  static String? deviceName;
  googleauth.GoogleSignInAccount? result;

  @override
  void initState() {
    getdevices();
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

  Future getdevices() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      deviceName = androidInfo.brand;
      deviceConfig = androidInfo.id;
      print('Running on ${androidInfo.type}');
    });
  }

  googleLogin() async {
    try {
      print("---googleLogin method Called----");
      final _googleSignIn = googleauth.GoogleSignIn();
      result = await _googleSignIn.signIn();
      // print("Result $result");
      // print("Result ${result!.authHeaders}");
      // print("Result ${result!.displayName}");
      // print("Result ${result!.email}");
      // print("Result ${result!.photoUrl}");
      // print("Result ${result!.authentication}");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CarouselSlider(
                items: images,
                // [
                //   Image.network(SvgImages
                //       .banner_1), // SvgPicture.asset(SvgImages.banner_1,),
                //   Image.network(SvgImages
                //       .banner_2), // SvgPicture.asset(SvgImages.banner_2),
                //   Image.network(SvgImages
                //       .banner_3), // SvgPicture.asset(SvgImages.banner_3),
                //   Image.network(SvgImages
                //       .banner_4), // SvgPicture.asset(SvgImages.banner_4),
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
            ),
            FractionallySizedBox(
              widthFactor: 0.80,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                          color: ColorResources.textblack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      margin:const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Email Id',
                        ),
                        validator:
                            ValidationBuilder().required().email().build(),
                        onChanged: (value) {
                          _formkey.currentState!.validate();
                        },
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 61, 72, 91),
                                  width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Mobile No.',
                        ),
                        validator: ValidationBuilder()
                            .required()
                            .phone()
                            .maxLength(10)
                            .minLength(10)
                            .build(),
                        onChanged: (value) {
                          _formkey.currentState!.validate();
                        },
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Full name',
                        ),
                        validator: ValidationBuilder().required().build(),
                        onChanged: (value) {
                          _formkey.currentState!.validate();
                        },
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
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
                        validator: ValidationBuilder()
                            .required()
                            .minLength(8)
                            .regExp(
                                RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                                'valid password ex:Testing@1')
                            .maxLength(50)
                            .build(),
                        onChanged: (value) {
                          _formkey.currentState!.validate();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      decoration: BoxDecoration(
                          color: ColorResources.buttoncolor,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            callApiRegister();
                          } else {
                            flutterToast('pls enter all required fields');
                            print("Unsuccessful");
                          }
                          //   Navigator.of(context).pushNamed('otpverification');
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
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
                      children: const [
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                        Text("Or Register with"),
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
                        const Text('Create an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed('SignIn');
                            },
                            child: Text(
                              ' Login',
                              style: TextStyle(
                                  color: ColorResources.buttoncolor),
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

  Future<BaseModel<Register>> callApiRegister() async {
    Register response;
    Map<String, dynamic> body = {
      "FullName": _nameController.text,
      "email": _emailController.text,
      "mobileNumber": _numberController.text,
      "password": _passwordController.text,
      "deviceConfig": deviceConfig,
      "deviceName": deviceName
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response = await RestClient(RetroApi2().dioData2()).registerRequest(body);
      await SharedPreferenceHelper.setString(
          Preferences.auth_token, response.data!.token.toString());
      await Languages.initState();
      await SharedPreferenceHelper.setString(
          Preferences.name, _nameController.text);
      await SharedPreferenceHelper.setString(
          Preferences.phoneNUmber, _numberController.text);
      await SharedPreferenceHelper.setString(
          Preferences.email, _emailController.text);
      if (response.status!) {
        setState(() {
          Preferences.hideDialog(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) =>
                  Otpverification(number: _numberController.text)),
            ),
          );
          print(response.data!.token);

          Fluttertoast.showToast(
            msg: '${response.data!.mobileNumberVerificationOTP}',
            toastLength: Toast.LENGTH_LONG,
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
        });
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
        if (response.data!.verified) {
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
          await SharedPreferenceHelper.setString(
              Preferences.profileImage, response.data!.profilePhoto);
          await SharedPreferenceHelper.setString(
              Preferences.address, response.data!.address);
          Navigator.of(context).pushNamed('home');
        } else {
          await SharedPreferenceHelper.setString(
              Preferences.name, response.data!.fullName);
          await SharedPreferenceHelper.setString(
              Preferences.email, response.data!.email);
          await SharedPreferenceHelper.setString(
              Preferences.auth_token, response.data!.verificationToken);
          SharedPreferenceHelper.setString(
              Preferences.profileImage, response.data!.profilePhoto);
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
