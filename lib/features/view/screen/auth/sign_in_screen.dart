import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/controller/global_controller.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/screen/auth/mobile_number_screen.dart';
import 'package:upsc_web/features/view/screen/auth/reset_password_screen.dart';
import 'package:upsc_web/features/view/widget/auth_button.dart';
import 'package:upsc_web/features/view/widget/custom_text_field.dart';
import 'package:upsc_web/utils/utils.dart';
import 'package:upsc_web/utils/images_file.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Widget> bannerList = [];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late Future<List<Widget>> getBanner;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getBanner = GlobalController.getBanner('APP');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            emailController.clear();
            passwordController.clear();
            if (state is LoginSuccess) {
              Utils.hideLoading(context);
              Navigator.popAndPushNamed(context, AppRoute.homeScreen);
            }
            if (state is UnVerifiedNumber) {
              Utils.hideLoading(context);
              Navigator.popAndPushNamed(
                context,
                AppRoute.otpVerificationScreen,
                arguments: [bannerList, state.phoneNumber],
              );
            }
            if (state is ErrorAuth) {
              Utils.hideLoading(context);
            }
            if (state is RequestToLogout) {
              Navigator.popAndPushNamed(
                context,
                AppRoute.requestToLogoutScreen,
                arguments: [emailController.text, bannerList],
              );
            }
            if (state is GoogleSuccess) {
              print(state);
              Navigator.pushNamed(context, AppRoute.homeScreen);
            }
            if (state is GooglePhoneNumberVerification) {
              print(state);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MobileNumberScreen(images: bannerList),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAuth) {
              return const CircularProgressIndicator();
            }
            return Container(
              constraints: const BoxConstraints(maxWidth: 375),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder<List<Widget>>(
                          future: getBanner,
                          builder: (context, snapshots) {
                            if (snapshots.connectionState ==
                                ConnectionState.done) {
                              if (snapshots.hasData) {
                                bannerList = snapshots.data!;
                                return CarouselSlider(
                                  items: snapshots.data,
                                  options: CarouselOptions(
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                );
                              } else if (snapshots.hasError) {}
                              return Text('Something went wrong');
                            } else {
                              return Center();
                            }
                          }),
                    ),
                    Text('Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    CustomTextFilled(
                      hintText: 'Email Id',
                      textController: emailController,
                      validator: ValidationBuilder().required().email().build(),
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Utils.buttonColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    AuthButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginButton;
                        }
                      },
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Text(
                          "Or Sign in with",
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
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
                          'Create an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.signupScreen,
                                    arguments: bannerList)
                                .then((value) => {
                                      emailController.clear(),
                                      passwordController.clear(),
                                    });
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(
                              color: Utils.buttonColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _loginButton() async {
    var body = {
      "email_phoneNumber": emailController.text,
      "password": passwordController.text,
    };
    Utils.showLoading(context);
    BlocProvider.of<AuthCubit>(context).loginUser(body);
  }
}
