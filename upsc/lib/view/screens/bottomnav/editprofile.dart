import 'package:flutter/material.dart';
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
  void initState(){
    name = SharedPreferenceHelper.getString(Preferences.name)!;
    email = SharedPreferenceHelper.getString(Preferences.email)!;
    phoneNumber = SharedPreferenceHelper.getString(Preferences.phoneNUmber)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    Icon(
                      Icons.account_circle,
                      color: ColorResources.gray,
                      size: 200,
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
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
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.transparent,
                      decorationColor: ColorResources.edit,
                      decorationThickness: 5,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      shadows: [
                        Shadow(
                          color: ColorResources.edit,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text('UPSC Aspirant'),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Languages.phoneText),
                    TextField(
                      controller: TextEditingController()
                        ..text = '+91 $phoneNumber',
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
                          hintText: Languages.phoneText,
                          suffixText: 'Edit'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(Languages.emailText),
                    TextField(
                      controller: TextEditingController()
                        ..text = email,
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
                          hintText: Languages.emailText,
                          suffixText: 'Edit'),
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
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