import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/register.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/otpverification.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Image.asset(SvgImages
                      .banner_1), // SvgPicture.asset(SvgImages.banner_1,),
                  Image.asset(SvgImages
                      .banner_2), // SvgPicture.asset(SvgImages.banner_2),
                  Image.asset(SvgImages
                      .banner_3), // SvgPicture.asset(SvgImages.banner_3),
                  Image.asset(SvgImages
                      .banner_4), // SvgPicture.asset(SvgImages.banner_4),
                ],
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
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
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create Account',
                        style: TextStyle(
                            color: ColorResources.textblack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent, width: 32.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Email Id',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _numberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 61, 72, 91),
                                    width: 32.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Mobile No.',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent, width: 32.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Full name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueAccent, width: 32.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_outlined),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(
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
                        height: 40,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(SvgImages.google),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(SvgImages.apple),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create an account?'),
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
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response = await RestClient(RetroApi2().dioData2()).registerRequest(body);
      await SharedPreferenceHelper.setString(
          Preferences.auth_token, response.data!.token.toString());
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
