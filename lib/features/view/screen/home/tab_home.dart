import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/controller/auth_controller.dart';
import 'package:upsc_web/features/view/cubit/bottom_tab/bottom_tab_cubit.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/course_tab.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/home_tab.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/profile/profile_tab.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index==1){
      BlocProvider.of<BottomTabCubit>(context).courseTab();
    }else if(index ==2){
      BlocProvider.of<BottomTabCubit>(context).mockTestTab();
    }else if(index == 3){
      BlocProvider.of<BottomTabCubit>(context).profileTab();
    }else{
      BlocProvider.of<BottomTabCubit>(context).homeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.only(left: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: const Color(0xFFF6CBB4),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Notification',
                  style: GoogleFonts.notoSansDevanagari(
                      color: Color(0xFF783B3B), fontSize: 12),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).pushNamed('notifications');
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Stack(
                        children: [
                          const Center(
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: Color(0xFF783B3B),
                                size: 18,
                              )),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 11,
                              left: 17,
                              top: 9,
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: drawer(context,true),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.book), label: "Courses"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.book_rounded), label: "Test"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: _onItemTapped,
      ),
      body: BlocConsumer<DrawerCubit, DrawerState>(
        listener: (context, state) {
          if (state is MyCartState) {
            Navigator.popAndPushNamed(context, AppRoute.myCartScreen);
          }
          if (state is MyCoursesState) {
            Navigator.popAndPushNamed(context, AppRoute.myCoursesScreen);
          }
          if (state is AboutUsState) {
            Navigator.popAndPushNamed(context, AppRoute.aboutUsScreen);
          }
          if (state is HelpAndSupport) {
            Navigator.popAndPushNamed(context, AppRoute.helpAndSupport);
          }
          if (state is ContactUs) {
            Navigator.popAndPushNamed(context, AppRoute.contactUs);
          }
          if (state is ShareApp) {
            // Navigator.popAndPushNamed(context, AppRoute.aboutUsScreen);
          }
          if (state is Setting) {
            Navigator.popAndPushNamed(context, AppRoute.languageScreen);
          }
          if (state is Resources) {
            Navigator.popAndPushNamed(context, AppRoute.resourcesScreen);
          }
          if (state is Scheduler) {
            Navigator.popAndPushNamed(context, AppRoute.schedulerScreen);
          }
          if (state is Logout) {
            Navigator.pop(context);
            logout(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<BottomTabCubit, BottomTabState>(
            builder: (context, state) {
              if (state is CourseTabState) {
                return CoursesScreen();
              }
              else if (state is MockTestTabState) {
                return Container();
              }
              else if (state is ProfileTabState) {
                return ProfileTab();
              } else {
                return HomeTab();
              }
            },
          );
        },
      ),

    );
  }

  void logout(BuildContext context) async {
    AuthController authController = AuthController();
    if (await authController.logout(context)) {
      PreferencesHelper.clearPref();
      PreferencesHelper.setBoolean(Preferences.isLoggedIn, false);
      Navigator.pushReplacementNamed(context, AppRoute.signInScreen);
    }
  }
}
