import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upsc_web/features/controller/auth_controller.dart';
import 'package:upsc_web/features/view/cubit/profile/cubit/profile_cubit.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences.dart';
import 'package:upsc_web/services/local_services/share_preferences/preferences_helper.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/images_file.dart';
import 'package:upsc_web/utils/langauge.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = 'Address';
  String profileImage = SvgImages.avatar;

  AuthController authController = AuthController();

  @override
  void initState() {
    name = PreferencesHelper.getString(Preferences.name)!;
    email = PreferencesHelper.getString(Preferences.email)!;
    phoneNumber = PreferencesHelper.getString(Preferences.phoneNUmber)!;
    address = PreferencesHelper.getString(Preferences.address)!;
    profileImage = PreferencesHelper.getString(Preferences.profileImage)!;
    super.initState();
  }

  bool isEnable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          elevation: 0,
          iconTheme: IconThemeData(
            color: ColorResources.textblack,
          ),
          title: Text(
            Languages.personalInformation,
            style:
                GoogleFonts.notoSansDevanagari(color: ColorResources.textblack),
          ),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(profileImage),
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: getImage,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: ColorResources.buttoncolor,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.mode,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isEnable = !isEnable;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.mode,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          scrollPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            name = value;
                          },
                          textAlign: TextAlign.center,
                          enabled: isEnable,
                          initialValue: name,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none),
                          style: GoogleFonts.notoSansDevanagari(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text('UPSC Aspirant'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Languages.mobile),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.gray, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '+91 $phoneNumber',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(Languages.emailText),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorResources.gray, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(email),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Address'),
                      TextField(
                        onChanged: (value) {
                          address = value;
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.gray, width: 1.0),
                          ),
                          hintText: address,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                            color: ColorResources.buttoncolor,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: () async {
                            if (await authController.updateUserDetails(
                                name, address)) {
                              context.read<ProfileCubit>().getProfile();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            Languages.saveChanges,
                            style: GoogleFonts.notoSansDevanagari(
                                color: ColorResources.textWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (await authController.updateUserProfilePhoto(image!)) {
    } else {
      BlocProvider.of<ProfileCubit>(context).getProfile();
    }
  }
}
