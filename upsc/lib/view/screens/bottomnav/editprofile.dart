import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upsc/features/data/remote/data_sources/auth/auth_data_source_impl.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/images_file.dart';
import 'package:upsc/util/langauge.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

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

  final authDataSourceImpl = AuthDataSourceImpl();

  @override
  void initState() {
    name = SharedPreferenceHelper.getString(Preferences.name)!;
    email = SharedPreferenceHelper.getString(Preferences.email)!;
    phoneNumber = SharedPreferenceHelper.getString(Preferences.phoneNUmber)!;
    address = SharedPreferenceHelper.getString(Preferences.address)!;
    profileImage = SharedPreferenceHelper.getString(Preferences.profileImage)!;
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
                        backgroundImage:
                            CachedNetworkImageProvider(profileImage),
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
                            print(isEnable);
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
                          style:  GoogleFonts.notoSansDevanagari(
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
                            try {
                              Preferences.onLoading(context);
                              Response response = await authDataSourceImpl
                                  .updateUserDetails(name, address);
                              if (response.statusCode == 200) {
                                SharedPreferenceHelper.setString(
                                  Preferences.name,
                                  name,
                                );
                                SharedPreferenceHelper.setString(
                                  Preferences.address,
                                  address,
                                );
                                flutterToast(response.data['msg']);
                                Preferences.hideDialog(context);
                                Navigator.of(context).pop();
                              } else {
                                Preferences.hideDialog(context);
                                flutterToast(response.data['msg']);
                              }
                            } catch (error) {
                              Preferences.hideDialog(context);
                              flutterToast('Server Error');
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

    try {
      Response response =
          await authDataSourceImpl.updateUserProfilePhoto(image!);
      if (response.statusCode == 200) {
        await SharedPreferenceHelper.setString(
          Preferences.profileImage,
          response.data['data']['fileUploadedLocation'],
        );
        var Image = SharedPreferenceHelper.getString(Preferences.profileImage)!;
        setState(() {
          profileImage = response.data['data']['fileUploadedLocation'];
        });
        flutterToast(response.data['msg']);
      } else {
        flutterToast(response.data['msg']);
      }
    } catch (error) {
      flutterToast('Server Error');
    }
  }
}
