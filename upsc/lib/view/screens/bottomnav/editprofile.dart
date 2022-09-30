import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
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
            'Personal Information',
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
                    'Pratik Gaur',
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
                    Text('   Mobile'),
                    TextField(
                      controller: TextEditingController()
                        ..text = '+91 99999 99999',
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
                          hintText: 'Mobile',
                          suffixText: 'Edit'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('   Email ID'),
                    TextField(
                      controller: TextEditingController()
                        ..text = 'pratik@xyz.com',
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
                          'Save Changes',
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
