import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/langauge.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {Key? key, required this.mobile, required this.web, required this.tab})
      : super(key: key);
  final Widget mobile;
  final Widget tab;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobile;
      } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1100) {
        return tab;
      }
      return web;
    });
  }
}

Drawer drawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          child: Container(
            decoration: BoxDecoration(
              color: ColorResources.buttoncolor,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "About Us",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () => BlocProvider.of<DrawerCubit>(context).aboutUs(),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    "My Cart",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).myCart();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.myCourses,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).myCourses();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.ourachievements,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // BlocProvider.of<DrawerCubit>(context).shareApp();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.mySchedule,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // BlocProvider.of<DrawerCubit>(context).shareApp();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.resources,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).resources();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.helpAndSupport,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).helpAndSupport();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.shareApp,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).shareApp();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    Languages.setting,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).setting();
                  },
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            PreferencesHelper.clearPref();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 0, bottom: 10, right: 30),
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
                  Text(
                    'Logout',
                    style: GoogleFonts.notoSansDevanagari(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
