
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:upsc_web/app_const.dart';
import 'package:upsc_web/features/controller/global_controller.dart';
import 'package:upsc_web/features/view/widget/auth_button.dart';
import 'package:upsc_web/features/view/widget/custom_text_field.dart';
import 'package:upsc_web/utils.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 375),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder<List<Widget>>(
                    future: GlobalController.getBanner(),
                    builder: (context,snapshots){
                  if(snapshots.connectionState == ConnectionState.done){
                    if(snapshots.hasData){
                      return CarouselSlider(
                        items: snapshots.data,
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
                      );
                    }else if(snapshots.hasError){
                      print(snapshots.error);
                      Util.toastMessage(snapshots.error.toString());
                    }
                    return Text('fgdfg');
                    // CarouselSlider(
                    //   items: images,
                    //   options: CarouselOptions(
                    //     viewportFraction: 1,
                    //     initialPage: 0,
                    //     enableInfiniteScroll: true,
                    //     reverse: false,
                    //     autoPlay: true,
                    //     autoPlayInterval: const Duration(seconds: 3),
                    //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    //     autoPlayCurve: Curves.fastOutSlowIn,
                    //     enlargeCenterPage: true,
                    //     scrollDirection: Axis.horizontal,
                    //   ),
                    // );
                  }else{
                    return Center();
                  }
                }),
              ),
              Text('Login',style: Theme.of(context).textTheme.headlineMedium),
              CustomTextFilled(hintText: 'Email Id'),
              PasswordTextFilled(),
              AuthButton(text: 'Login', onPressed: (){}),
              Row(
                children: [
                  const Expanded(
                      child: Divider(
                        thickness: 2,
                      )),
                  Text(
                    "Or Sign in with",
                  ),
                  const Expanded(
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
                  Text(
                    'Create an account?',
                  ),
                  TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(
                          color: Util.buttonColor,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
