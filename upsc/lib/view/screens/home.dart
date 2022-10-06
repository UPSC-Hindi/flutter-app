import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/bloc/courses/courses_bloc.dart';
import 'package:upsc/view/screens/bottomnav/coursescreen.dart';
import 'package:upsc/view/screens/bottomnav/homescreen.dart';
import 'package:upsc/view/screens/bottomnav/mocktestscreen.dart';
import 'package:upsc/view/screens/bottomnav/profile.dart';
import 'package:upsc/view/screens/languagescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
    });
  }

  static final List _widgetOptions = [
    const HomeScreens(),
    BlocProvider(
      create: (context) => CoursesBloc(),
      child: const CourseScreen(),
    ),
    const mocktestscreen(),
    const ProfilScreen()
  ];

  String name = "temp";
  @override
  void initState() {
    print('Is english');
    print(Languages.isEnglish);
    name = SharedPreferenceHelper.getString(Preferences.name)!;
    Languages.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorResources.textblack),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed('notifications');
              }),
              icon: const Icon(Icons.circle_notifications_outlined))
        ],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                ),
                color: ColorResources.buttoncolor,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      name,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          height: 1,
                          color: ColorResources.textWhite,
                          fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.info),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.aboutUs,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('downloadScreen');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.download_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.yourDownloads,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('cartscreen');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.myCart,
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('myordersscreen');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.list),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.myOrders,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('mycoursesscreen');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.myCourses,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('MySchedule');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.event_available_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.mySchedule,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('resourcesscreen');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.layers),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.resources,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('helpandsupport');
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(Icons.help_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.helpAndSupport,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.reply),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.shareApp,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageScreen(
                            isLogin: true,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: ColorResources.textblack, // Text Color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 0, bottom: 0, right: 0),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.settings),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.setting,
                            style: GoogleFonts.poppins(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                SharedPreferenceHelper.clearPref();
                Navigator.of(context).popAndPushNamed('/');
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, bottom: 10, right: 30),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.redAccent),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: Languages.home),
          BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.book), label: Languages.courses),
          BottomNavigationBarItem(
              icon: const Icon(Icons.book_rounded), label: Languages.mockTest),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: Languages.profile),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: _onItemTapped,
      ),
    );
  }
}
