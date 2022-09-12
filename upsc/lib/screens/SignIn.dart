import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          color: ColorResources.textblack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: 'Email Id',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 32.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: ColorResources.buttoncolor),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      decoration: BoxDecoration(
                          color: ColorResources.buttoncolor,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
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
                        Text("Or Sign in with"),
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
                              Navigator.of(context).pushNamed('SignUp');
                            },
                            child: Text(
                              ' Register',
                              style:
                                  TextStyle(color: ColorResources.buttoncolor),
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
}
