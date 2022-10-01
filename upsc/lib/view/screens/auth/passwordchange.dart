import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upsc/api/Retrofit_Api.dart';
import 'package:upsc/api/base_model.dart';
import 'package:upsc/api/network_api.dart';
import 'package:upsc/api/server_error.dart';
import 'package:upsc/models/auth/resetpassword.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/util/preference.dart';
import 'package:upsc/view/screens/auth/passwordVerified.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({Key? key}) : super(key: key);

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final _password = TextEditingController();
  final _rpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'New Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _rpassword,
              decoration: const InputDecoration(
                  hintText: 'Confirm Password', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                callApipasswordverifyotp();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: ((context) => passwordVerified(
                //           type: 'change',
                //         )),
                //   ),
                // );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                child: Text(
                  'Change Password',
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
    ));
  }

  Future<BaseModel<ResetPassword>> callApipasswordverifyotp() async {
    ResetPassword response;
    var userdata =
        await SharedPreferenceHelper.read(Preferences.password_change_data);
    print(userdata);
    Map<String, dynamic> body = {
      "email_phoneNumber": userdata,
      "NewPassword": _password.text,
      "ConfirmPassword": _rpassword.text
    };
    setState(() {
      Preferences.onLoading(context);
    });
    try {
      response =
          await RestClient(RetroApi2().dioData2()).resetpasswordRequest(body);
      setState(() {
        Preferences.hideDialog(context);
        if (response.status!) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: ((context) => PasswordOtp(Otpfor: _data!)),
          //   ),
          // );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => passwordVerified(
                    type: 'change',
                  )),
            ),
          );
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
}
