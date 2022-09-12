import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              icon: Icon(Icons.circle_notifications_outlined))
        ],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Your Profile',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.layers_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Resources',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.menu_book),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Courses',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.text_snippet_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Mock Tests',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.notification_important),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Important Updates',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.download_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Your Downloads',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.graph_square),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Your Progress',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Divider(),
              ]),
              Container(
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
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    )
                  ],
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
