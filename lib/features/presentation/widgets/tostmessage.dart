
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upsc/util/color_resources.dart';

void flutterToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorResources.gray,
      textColor: ColorResources.textWhite,
      fontSize: 14.0);
}