import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart' as googleauth;
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/controller/global_controller.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
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
  googleauth.GoogleSignInAccount? result;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Widget> bannerList = [];
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

  late Future<List<Widget>>getBanner;
  @override
  void initState() {
    getBanner = GlobalController.getBanner();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is LoginSuccess){
                Utils.hideLoading(context);
                Navigator.popAndPushNamed(context, AppRoute.homeScreen);
              }
              if(state is UnVerifiedNumber){
                Utils.hideLoading(context);
                Navigator.popAndPushNamed(context, AppRoute.otpVerificationScreen,arguments: [bannerList,state.phoneNumber]);
              }
              if(state is ErrorAuth){
                Utils.hideLoading(context);
              }
            },
            builder: (context, state) {
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
                    ),
                    PasswordTextFilled(
                      textEditingController: passwordController,
                    ),
                    AuthButton(
                        text: 'Login',
                        onPressed: _loginButton,),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        ),),
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
                          onTap: () {},
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
                              Navigator.pushNamed(
                                  context, AppRoute.signupScreen,
                                arguments: bannerList
                              ).then((value) =>{
                                emailController.clear(),
                                passwordController.clear(),
                              });
                            },
                            child: Text(
                              ' Register',
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

  void _loginButton() async{
    var body = {
      "email_phoneNumber": emailController.text,
      "password": passwordController.text,
    };
    Utils.showLoading(context);
    BlocProvider.of<AuthCubit>(context).loginUser(body);
  }
}
