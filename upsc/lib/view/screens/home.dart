import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/features/data/remote/data_sources/remote_data_source_impl.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/language_screen.dart';
import 'package:upsc/view/screens/bottomnav/coursescreen.dart';
import 'package:upsc/view/screens/bottomnav/homescreen.dart';
import 'package:upsc/view/screens/bottomnav/mocktestscreen.dart';
import 'package:upsc/view/screens/bottomnav/profile.dart';

class HomeScreen extends StatefulWidget {
  final int? index;
  const HomeScreen({Key? key, this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String _profileimage =
      SharedPreferenceHelper.getString(Preferences.profileImage) != "N/A"
          ? SharedPreferenceHelper.getString(Preferences.profileImage)!
          : SvgImages.avatar;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _widgetOptions = [
    const HomeScreens(),
    const CourseScreen(),
    mocktestscreen(remoteDataSourceImpl: RemoteDataSourceImpl()),
    ProfilScreen()
  ];

  String name = "temp";

  @override
  void initState() {
    widget.index != null ? _onItemTapped(widget.index!) : print("back");
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
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
              padding: const EdgeInsets.only(left: 1.0),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: const Color(0xFFF6CBB4),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    //'Notification'
                    Languages.Notification,
                    style: GoogleFonts.notoSansDevanagari(
                        color: const Color(0xFF783B3B), fontSize: 12),
                  ),
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
      drawer: SafeArea(
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10),
                height: MediaQuery.of(context).size.height * 0.15,
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
                      backgroundImage:
                          CachedNetworkImageProvider(_profileimage!),
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Text(
                        name,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: GoogleFonts.notoSansDevanagari(
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
                        Navigator.of(context).pushNamed('aboutusscreen');
                      },
                      style: TextButton.styleFrom(
                        primary: ColorResources.textblack, // Text Color
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.info),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.aboutUs,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.download_rounded),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.yourDownloads,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.myCart,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.list),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.myOrders,
                              style: GoogleFonts.notoSansDevanagari(
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
                        Navigator.of(context)
                            .popAndPushNamed('mycoursesscreen');
                      },
                      style: TextButton.styleFrom(
                        primary: ColorResources.textblack, // Text Color
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.menu_book),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.myCourses,
                              style: GoogleFonts.notoSansDevanagari(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: ColorResources.textblack),
                            )
                          ],
                        ),
                      ),
                    ),
                    // const Divider(),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).popAndPushNamed('mytestseries');
                    //   },
                    //   style: TextButton.styleFrom(
                    //     primary: ColorResources.textblack, // Text Color
                    //   ),
                    //   child: Container(
                    //     padding: const EdgeInsets.only(
                    //         left: 16, top: 0, bottom: 0, right: 0),
                    //     child: Row(
                    //       children: [
                    //         const Icon(Icons.text_snippet),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           Languages.myTestseries,
                    //           style: GoogleFonts.notoSansDevanagari(
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 20,
                    //               color: ColorResources.textblack),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popAndPushNamed('ourachievements');
                      },
                      style: TextButton.styleFrom(
                        primary: ColorResources.textblack, // Text Color
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.people),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.ourachievements,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.event_available_rounded),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.mySchedule,
                              style: GoogleFonts.notoSansDevanagari(
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
                        Navigator.of(context)
                            .popAndPushNamed('resourcesscreen');
                      },
                      style: TextButton.styleFrom(
                        primary: ColorResources.textblack, // Text Color
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.layers),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.resources,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(Icons.help_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.helpAndSupport,
                              style: GoogleFonts.notoSansDevanagari(
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
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.reply),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.shareApp,
                              style: GoogleFonts.notoSansDevanagari(
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
                            builder: (context) => const LanguageScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        primary: ColorResources.textblack, // Text Color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, bottom: 0, right: 0),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.settings),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Languages.setting,
                              style: GoogleFonts.notoSansDevanagari(
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
                      left: 16, top: 0, bottom: 10, right: 30),
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
                            style: GoogleFonts.notoSansDevanagari(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
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
              icon: const Icon(Icons.book_rounded), label: Languages.Test),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: Languages.profile),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: _onItemTapped,
      ),
    );
  }

  callApilogout() async {
    //Logout response;
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      var token = SharedPreferenceHelper.getString(Preferences.access_token);

      SharedPreferenceHelper.clearPref();
      Navigator.of(context).pushNamedAndRemoveUntil('/',(Route<dynamic> route) => false);
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }
}
