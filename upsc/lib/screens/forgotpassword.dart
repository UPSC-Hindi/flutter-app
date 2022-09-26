import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/forgotpassword.dart';
import 'package:upsc/models/register.dart';
import 'package:upsc/screens/passwordotp.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Reset Password',
                style: GoogleFonts.poppins(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _numberController,
                      decoration: InputDecoration(
                          hintText: 'Mobile No.', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Or',
                      style: GoogleFonts.lato(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'Email ID', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        callApiforgotpassword();
                        //Navigator.of(context).pushNamed('passwordotp');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40),
                        child: Text(
                          'Send OTP',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<BaseModel<ForgetPassword>> callApiforgotpassword() async {
    ForgetPassword response;
    String? _data;
    if (_numberController.text != '') {
      setState(() {
        _data = _numberController.text;
      });
    } else if (_emailController.text != '') {
      setState(() {
        _data = _emailController.text;
      });
    }
    print(_data);
    Map<String, dynamic> body = {
      "email_phoneNumber": _data,
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response =
          await RestClient(RetroApi2().dioData2()).forgetpasswordRequest(body);
      setState(() {
        Preferences.hideDialog(context);
        if (response.status!) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => PasswordOtp(Otpfor: _data!)),
            ),
          );
        } else {
          print('check');
        }
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
