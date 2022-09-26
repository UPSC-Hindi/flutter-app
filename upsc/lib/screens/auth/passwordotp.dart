import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/passwordotpresend.dart';
import 'package:upsc/models/auth/passwordverifyotp.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class PasswordOtp extends StatefulWidget {
  String Otpfor;
  PasswordOtp({Key? key, required this.Otpfor}) : super(key: key);

  @override
  State<PasswordOtp> createState() => _PasswordOtpState();
}

class _PasswordOtpState extends State<PasswordOtp> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? otpdatafor;
  String? Otp;
  @override
  void initState() {
    super.initState();
    setState(() {
      otpdatafor = widget.Otpfor;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  final length = 4;
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: const Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'OTP sent on',
                style: TextStyle(
                    color: ColorResources.textblack,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  ' $otpdatafor  Change',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                length: length,
                controller: controller,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                onCompleted: (pin) {
                  setState(() => Otp = pin);
                },
                focusedPinTheme: defaultPinTheme.copyWith(
                  height: 68,
                  width: 64,
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: borderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                decoration: BoxDecoration(
                    color: ColorResources.buttoncolor,
                    borderRadius: BorderRadius.circular(14)),
                child: TextButton(
                  onPressed: () {
                    callApipasswordverifyotp();
                    //Navigator.of(context).popAndPushNamed('passwordverified');
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(
                        color: ColorResources.textWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Did not recieve the code?'),
                  TextButton(
                    onPressed: () {
                      callApipasswordotpresend();
                      //Navigator.of(context).popAndPushNamed('SignIn');
                    },
                    child: Text(
                      ' Try again',
                      style: TextStyle(color: ColorResources.buttoncolor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<BaseModel<PasswordVerifyOtp>> callApipasswordverifyotp() async {
    PasswordVerifyOtp response;

    Map<String, dynamic> body = {"email_phoneNumber": otpdatafor, "otp": Otp};
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response = await RestClient(RetroApi2().dioData2())
          .passwordverifyotpRequest(body);
      setState(() {
        Preferences.hideDialog(context);
        if (response.status!) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: ((context) => PasswordOtp(Otpfor: _data!)),
          //   ),
          // );
          Navigator.of(context).popAndPushNamed('passwordverified');
          SharedPreferenceHelper.write(
              Preferences.password_change_data, otpdatafor);
        } else {
          print('check');
        }

        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      });
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<PasswordOtpResend>> callApipasswordotpresend() async {
    PasswordOtpResend response;

    Map<String, dynamic> body = {"email_phoneNumber": otpdatafor};
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response = await RestClient(RetroApi2().dioData2())
          .passwordotpresendRequest(body);
      setState(() {
        Preferences.hideDialog(context);
        Fluttertoast.showToast(
          msg: '${response.data!.otpToResetPassword}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
        Fluttertoast.showToast(
          msg: '${response.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorResources.gray,
          textColor: ColorResources.textWhite,
        );
      });
    } catch (error, stacktrace) {
      setState(() {
        Preferences.hideDialog(context);
      });
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
