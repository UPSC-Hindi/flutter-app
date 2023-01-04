import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/home.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? _profileimage;

  @override
  void initState() {
    super.initState();
    _profileimage =
        SharedPreferenceHelper.getString(Preferences.profileImage) != "N/A"
            ? SharedPreferenceHelper.getString(Preferences.profileImage)!
            : SvgImages.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(SvgImages.backgroung),
              fit: BoxFit.values[0],
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage:
                            CachedNetworkImageProvider(_profileimage!),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Text(
                      SharedPreferenceHelper.getString(Preferences.name)
                          .toString(),
                      style: GoogleFonts.notoSansDevanagari(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('UPSC Aspirant')
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed('editprofilescreen')
                    .then((value) {
                  setState(() {
                    _profileimage = SharedPreferenceHelper.getString(
                        Preferences.profileImage)!;
                  });
                }),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.account_circle_outlined, size: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.personalInformation,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Languages.editProfile,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                      index: 2,
                    ),
                  ));
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.bookmark, size: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.yourTestSeries,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Languages.seeYourEnrollTest,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('mycoursesscreen');
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.auto_stories, size: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.courses,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Languages.seeYourEnrollCourses,
                            style: GoogleFonts.notoSansDevanagari(
                              color: ColorResources.textblack.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => callApilogout(),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.textWhite,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.logout),
                      Text(
                        'Logout',
                        style: GoogleFonts.notoSansDevanagari(
                          color: ColorResources.textblack,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  callApilogout() async {
    //Logout response;
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      //var token = SharedPreferenceHelper.getString(Preferences.access_token);
      //response = await RestClient(RetroApi().dioData(token!)).logoutRequest();
      //if (response.status!) {
        setState(() {
          Preferences.hideDialog(context);
        });
        // Fluttertoast.showToast(
        //   msg: '${response.msg}',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: ColorResources.gray,
        //   textColor: ColorResources.textWhite,
        // );
        SharedPreferenceHelper.clearPref();
        Navigator.of(context).popAndPushNamed('/');
      // } else {
      //   Fluttertoast.showToast(
      //     msg: '${response.msg}',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: ColorResources.gray,
      //     textColor: ColorResources.textWhite,
      //   );
      // }
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      // print("Exception occur: $error stackTrace: $stacktrace");
      // return BaseModel()..setException(ServerError.withError(error: error));
    }
    //return BaseModel()..data = response;
  }
}
