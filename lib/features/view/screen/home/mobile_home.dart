import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/course_tab.dart';
import 'package:upsc_web/features/view/screen/bottom_navigation/home_tab.dart';
import 'package:upsc_web/features/view/widget/responsive_widget.dart';
import 'package:upsc_web/utils/color_resources.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _widgetOptions = [
    HomeTab(),
    const CoursesScreen(),
    Container(),
    Container(),
    //   const CourseScreen(),
    //   const mocktestscreen(),
    //   ProfilScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrawerCubit, DrawerState>(
      listener: (context, state) {
        if (state is MyCartState) {
          Navigator.popAndPushNamed(context, AppRoute.myCartScreen);
        }
        if(state is MyCoursesState){
          Navigator.popAndPushNamed(context, AppRoute.myCoursesScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: ColorResources.textblack),
            backgroundColor: Colors.white,
            actions: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
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
          drawer: drawer(context),
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
          body: _widgetOptions[_selectedIndex],
        );
      },
    );
  }
}
