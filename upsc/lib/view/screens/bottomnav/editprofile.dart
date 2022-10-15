import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upsc/util/color_resources.dart';
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

  @override
  void initState() {
    name = SharedPreferenceHelper.getString(Preferences.name)!;
    email = SharedPreferenceHelper.getString(Preferences.email)!;
    phoneNumber = SharedPreferenceHelper.getString(Preferences.phoneNUmber)!;
    super.initState();
  }

  final profileImage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: ColorResources.textWhite,
          elevation: 0,
          iconTheme: IconThemeData(
            color: ColorResources.textblack,
          ),
          title: Text(
            Languages.personalInformation,
            style: TextStyle(color: ColorResources.textblack),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    profileImage.isEmpty
                        ? Icon(
                            Icons.account_circle,
                            color: ColorResources.gray,
                            size: 200,
                          )
                        : Image.file(
                            File(profileImage),
                          ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            // profileImage = image;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: ColorResources.buttoncolor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.mode,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text('UPSC Aspirant'),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Languages.mobile),
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorResources.gray, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '+91 $phoneNumber',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Languages.emailText),
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorResources.gray, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(email),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('   Address'),
                    TextField(
                      controller: TextEditingController()
                        ..text = 'XYZ Street, Abc Road Gujarat - 30000',
                      maxLines: 3,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorResources.gray, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.gray, width: 1.0),
                          ),
                          hintText: 'Email ID',
                          suffixText: 'Edit'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                          color: ColorResources.buttoncolor,
                          borderRadius: BorderRadius.circular(14)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName('login'));
                          Navigator.of(context).pushNamed('home');
                        },
                        child: Text(
                          Languages.saveChanges,
                          style: TextStyle(
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
        ));
  }
}
