import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upsc/features/cubit/auth/auth_cubit.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';


class RequestLogoutScreen extends StatelessWidget {
  const RequestLogoutScreen(
      {Key? key, required this.userEmail, required this.bannerList})
      : super(key: key);
  final String userEmail;
  final List<Widget> bannerList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: bannerList,
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                BlocConsumer<AuthCubit,AuthState>(builder: (context,state){
                  if(state is RequestLogoutSuccess){
                    return Column(
                      children: [
                        const SizedBox(height: 10,),
                        Text('Thank You!',style: Theme.of(context).textTheme.headline2,),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal:40.0),
                          child: Text("We have sent your request to admin, we will notify you as soon as the admin approve your request",),
                        ),
                      ],
                    );
                  }
                  else{
                    return _bodyWidget(context);
                  }
                }, listener: (context,state){
                  if(state is ErrorAuth || state is LoadingAuth){
                    Preferences.hideDialog(context);
                  }
                  if(state is RequestLogoutSuccess){
                    Preferences.hideDialog(context);
                    Future.delayed(Duration(milliseconds: 500),(){
                      Navigator.pop(context);
                    });
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _bodyWidget(BuildContext context) {
    return Column(
                children: [
                  Text(
                    'Dear User',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You have tried to login from another device.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "That's why you are here.",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'Please request to admin for allowing this dedvice',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ColorResources.textblack,
                      ),
                    ),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Request to Admin! Type your Message'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).requestLogout(userEmail);
                    },
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: ColorResources.buttoncolor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Verify',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ],
              );
  }
}
