import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc_web/features/view/cubit/drawer/drawer_cubit.dart';
import 'package:upsc_web/features/view/cubit/profile/cubit/profile_cubit.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';

bool isWeb = false;
bool isMobile = false;
bool isTab = false;

double screenWidth = 500;
double screenHeight = 500;


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
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.width;
      if (constraints.maxWidth < 700) {
        isMobile = true;
        isWeb = false;
        isTab = false;
        return mobile;
      } else if (constraints.maxWidth > 700 && constraints.maxWidth < 1100) {
        isMobile = false;
        isWeb = false;
        isTab = true;
        return tab;
      }
      isMobile = false;
      isWeb = true;
      isTab = false;
      return web;
    });
  }
}

Drawer drawer(BuildContext context,bool isMobile) {
  return Drawer(
    child: Column(
      children: [
        isMobile?DrawerHeader(
          child: Container(
              decoration: BoxDecoration(
                color: ColorResources.buttoncolor,
              ),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                if (state is ProfileLoading) {
                  return CircularProgressIndicator();
                } else if (state is ProfileSuccess) {
                  return profileInfo(
                      context, state.userName, state.profileImage);
                } else {
                  return profileInfo(context, "UPSC", SvgImages.avatar);
                }
              })),
        ):Container(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info,color: ColorResources.textblack,),
                  title: Text(
                    "About Us",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () => BlocProvider.of<DrawerCubit>(context).aboutUs(),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart,color: ColorResources.textblack,),
                  title: Text(
                    Languages.myCart,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).myCart();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list,color: ColorResources.textblack,),
                  title: Text(
                    Languages.myOrders,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).myCart();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.menu_book,color: ColorResources.textblack,),
                  title: Text(
                    Languages.myCourses,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).myCourses();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.text_snippet,color: ColorResources.textblack,),
                  title: Text(
                    Languages.myTestseries,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // BlocProvider.of<DrawerCubit>(context).shareApp();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people,color: ColorResources.textblack,),
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
                  leading: Icon(Icons.event_available_rounded,color: ColorResources.textblack,),
                  title: Text(
                    Languages.mySchedule,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).scheduler();
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.layers,color: ColorResources.textblack,),
                  title: Text(
                    Languages.resources,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).resources();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outlined,color: ColorResources.textblack,),
                  title: Text(
                    Languages.helpAndSupport,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).helpAndSupport();
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.reply,color: ColorResources.textblack,),
                  title: Text(
                    Languages.shareApp,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onTap: () {
                    BlocProvider.of<DrawerCubit>(context).shareApp();
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.settings,color: ColorResources.textblack,),
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
            BlocProvider.of<DrawerCubit>(context).logout();
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

Row profileInfo(BuildContext context, String userName, String profileImage) {
  return Row(
    children: [
      CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage(profileImage),
        backgroundColor: Colors.grey,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.02,
      ),
      Expanded(
        child: Text(
          userName,
          overflow: TextOverflow.clip,
          maxLines: 2,
          style: GoogleFonts.notoSansDevanagari(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorResources.textWhite),
        ),
      ),
    ],
  );
}
