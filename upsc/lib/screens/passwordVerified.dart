import 'dart:async';
import 'package:flutter/material.dart';
import 'package:upsc/util/color_resources.dart';

class passwordVerified extends StatefulWidget {
  passwordVerified({Key? key, required this.type}) : super(key: key);
  final String? type;

  @override
  State<passwordVerified> createState() => _passwordVerifiedState();
}

class _passwordVerifiedState extends State<passwordVerified> {
  String? typer;
  @override
  void initState() {
    super.initState();
    typer = widget.type;
    print(typer);
    Timer(
      Duration(seconds: 3),
      () => typer != 'change'
          ? Navigator.of(context).popAndPushNamed('passwordchange')
          : Navigator.of(context).popAndPushNamed('SignIn'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Icon(
        Icons.verified,
        size: 200,
        color: ColorResources.buttoncolor,
      )),
    );
  }
}
