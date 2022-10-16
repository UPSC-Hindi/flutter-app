import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/Logout.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
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
  String? _profileimage =
      SharedPreferenceHelper.getString(Preferences.profileImage) != "N/A"
          ? SharedPreferenceHelper.getString(Preferences.profileImage)!
          : SvgImages.avatar;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List _widgetOptions = [
    const HomeScreens(),
    const CourseScreen(),
    const mocktestscreen(),
    const ProfilScreen()
  ];

  String name = "temp";

  @override
  void initState() {
    print('Is english');
    print(Languages.isEnglish);
    name = SharedPreferenceHelper.getString(Preferences.name)!;
    // Languages.isEnglish = SharedPreferenceHelper.getBoolean(Preferences.language)
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
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/images/menuIcon.png'),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
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
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(_profileimage!),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      name,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: ColorResources.textWhite),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Share.share('https://upschindi.in/');
                    },
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: ColorResources.textblack),
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
                callApilogout();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, bottom: 10, right: 30),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Logout',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.redAccent,
                          ))
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

  Future<BaseModel<Logout>> callApilogout() async {
    Logout response;

    try {
      var token = SharedPreferenceHelper.getString(Preferences.access_token);
      response = await RestClient(RetroApi().dioData(token!)).logoutRequest();
      if (response.status!) {
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
        SharedPreferenceHelper.clearPref();
        Navigator.of(context).popAndPushNamed('/');
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
