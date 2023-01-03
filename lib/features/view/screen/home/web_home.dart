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
import 'package:upsc_web/utils/images_file.dart';

class WebHome extends StatelessWidget {
  const WebHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.network(SvgImages.aboutLogo),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<BottomTabCubit>(context).homeTab();
                },
                child: Text('Home')),
            TextButton(
                onPressed: () {
                  BlocProvider.of<BottomTabCubit>(context).courseTab();
                },
                child: Text('Course')),
            TextButton(
                onPressed: () {
                  BlocProvider.of<BottomTabCubit>(context).mockTestTab();
                },
                child: Text('Mock Test')),
            TextButton(
                onPressed: () {
                  BlocProvider.of<BottomTabCubit>(context).profileTab();
                },
                child: Text('Profile')),
          ],
        ),
        actions: [
          InkWell(
            onTap: (() {
              Navigator.of(context).pushNamed('notifications');
            }),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
      body: Row(
        children: [
          Expanded(flex: 2, child: drawer(context,false)),
          Expanded(
            flex: 7,
            child: BlocConsumer<DrawerCubit, DrawerState>(
              listener: (context, state) {
                if (state is MyCartState) {
                  Navigator.pushNamed(context, AppRoute.myCartScreen);
                }
                if (state is MyCoursesState) {
                  Navigator.pushNamed(context, AppRoute.myCoursesScreen);
                }
                if (state is AboutUsState) {
                  Navigator.pushNamed(context, AppRoute.aboutUsScreen);
                }
                if (state is HelpAndSupport) {
                  Navigator.pushNamed(context, AppRoute.helpAndSupport);
                }
                if (state is ContactUs) {
                  Navigator.pushNamed(context, AppRoute.contactUs);
                }
                if (state is ShareApp) {
                  // Navigator.popAndPushNamed(context, AppRoute.aboutUsScreen);
                }
                if (state is Setting) {
                  Navigator.pushNamed(context, AppRoute.languageScreen);
                }
                if (state is Resources) {
                  Navigator.pushNamed(context, AppRoute.resourcesScreen);
                }
                if (state is Scheduler) {
                  Navigator.pushNamed(context, AppRoute.schedulerScreen);
                }
                if (state is Logout) {
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
          ),
        ],
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
