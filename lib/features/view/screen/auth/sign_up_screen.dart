import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/widget/auth_button.dart';
import 'package:upsc_web/features/view/widget/custom_text_field.dart';
import 'package:upsc_web/utils/utils.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'mobile_number_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.bannerList}) : super(key: key);
  final List<Widget> bannerList;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          if (state is GoogleSuccess) {
            Navigator.pushNamed(context, AppRoute.homeScreen);
          }
          if (state is GooglePhoneNumberVerification) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MobileNumberScreen(images: widget.bannerList),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is LoadingAuth) {
            return const CircularProgressIndicator();
          }
          return Container(
            constraints: const BoxConstraints(maxWidth: 375),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      validator: ValidationBuilder().required().email().build(),
                    ),
                    CustomTextFilled(
                      hintText: 'Mobile No.',
                      validator: ValidationBuilder()
                          .required()
                          .phone()
                          .maxLength(10)
                          .minLength(10)
                          .build(),
                      textController: numberController,
                    ),
                    CustomTextFilled(
                      hintText: 'Full name',
                      textController: nameController,
                      validator: ValidationBuilder().required().build(),
                    ),
                    PasswordTextFilled(
                      textEditingController: passwordController,
                      validator: ValidationBuilder()
                          .required()
                          .minLength(8)
                          .regExp(
                          RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                          'valid password ex:Testing@1')
                          .maxLength(50)
                          .build(),
                    ),
                    AuthButton(
                      text: 'Sign up',
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          _registerButton;
                        }
                      },
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
                            BlocProvider.of<AuthCubit>(context).googleAuth();
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
              ),
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
