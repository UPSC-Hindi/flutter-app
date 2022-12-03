import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/widget/auth_button.dart';
import 'package:upsc_web/features/view/widget/custom_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;
import 'package:upsc_web/utils/utils.dart';
import 'package:upsc_web/utils/images_file.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.bannerList}) : super(key: key);
  final List<Widget> bannerList;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  googleauth.GoogleSignInAccount? result;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
        //callApigooglelogin();
        print("--Email found---");
        print(result!.email);
        //await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    numberController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.popAndPushNamed(context, AppRoute.otpVerificationScreen,
                arguments: [widget.bannerList,numberController.text]);
          }
        }, builder: (context, state) {
          if (state is LoadingAuth) {
            return const CircularProgressIndicator();
          }
          return Container(
            constraints: const BoxConstraints(maxWidth: 375),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CarouselSlider(
                    items: widget.bannerList,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Text('Create Account',
                    style: Theme.of(context).textTheme.headlineMedium),
                CustomTextFilled(
                  hintText: 'Email Id',
                  textController: emailController,
                ),
                CustomTextFilled(
                  hintText: 'Mobile No.',
                  textController: numberController,
                ),
                CustomTextFilled(
                  hintText: 'Full name',
                  textController: nameController,
                ),
                PasswordTextFilled(
                  textEditingController: passwordController,
                ),
                AuthButton(
                  text: 'Sign up',
                  onPressed: _registerButton,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      thickness: 2,
                    )),
                    Text(
                      "Or Register with",
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("hello");
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
                        child: Image.network(SvgImages.google),
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
                      child: Image.network(SvgImages.apple),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I have an account. ',
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Utils.buttonColor,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _registerButton() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    var body = {
      "FullName": nameController.text,
      "email": emailController.text,
      "mobileNumber": numberController.text,
      "password": passwordController.text,
      "deviceConfig": webBrowserInfo.userAgent,
      "deviceName": webBrowserInfo.appName
    };
    BlocProvider.of<AuthCubit>(context).registerUser(body);
  }
}
