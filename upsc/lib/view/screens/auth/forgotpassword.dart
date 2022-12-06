import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/forgotpassword.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/auth/passwordotp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
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
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Reset Password',
                style: GoogleFonts.notoSansDevanagari(fontSize: 30),
              ),
            ),
            const SizedBox(
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
                      decoration: const InputDecoration(
                          hintText: 'Mobile No.', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Or',
                      style: GoogleFonts.lato(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email ID', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        callApiforgotpassword();
                        //Navigator.of(context).pushNamed('passwordotp');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ColorResources.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40),
                        child: Text(
                          'Send OTP',
                          style: GoogleFonts.notoSansDevanagari(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
    if (_numberController.text.isNotEmpty) {
      setState(() {
        _data = _numberController.text;
      });
    } else if (_emailController.text.isNotEmpty) {
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
