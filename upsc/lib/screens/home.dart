import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/screens/coursescreen.dart';
import 'package:upsc/screens/homescreen.dart';
import 'package:upsc/screens/mocktestscreen.dart';
import 'package:upsc/screens/profile.dart';
import 'package:upsc/util/color_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _widgetOptions = [
    HomeScreens(),
    coursescreen(),
    mocktestscreen(),
    ProfilScreen()
  ];

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 30),
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
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        'Pratik Gaur',
                        style: GoogleFonts.poppins(
                            color: ColorResources.textWhite, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // setState(() {
                    //   _selectedIndex = 3;
                    // });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'About Us',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed('downloadScreen'),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.download_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Your Downloads',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('cartscreen');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My Cart',
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('myordersscreen');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.list),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My Orders',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('mycoursesscreen');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.menu_book),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My Courses',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.event_available_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Important Updates',
                        style: GoogleFonts.poppins(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed('resourcesscreen'),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.layers),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Resources',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('helpandsupport');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.help_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Help & Support',
                          style: GoogleFonts.poppins(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.reply),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Share App',
                        style: GoogleFonts.poppins(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.settings),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
              ]),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed('/');
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style:
                              TextStyle(fontSize: 20, color: Colors.redAccent),
                        )
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded), label: 'Mock Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.buttoncolor,
        onTap: _onItemTapped,
      ),
    );
  }
}
