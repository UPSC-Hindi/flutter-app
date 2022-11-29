import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Util {

  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static Color buttonColor = const Color(0xFFED5067);

  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.white, textColor: Colors.white);
  }
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(Icons.error,size: 28,color: Colors.white,),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context)  ,
    );
  }
}
