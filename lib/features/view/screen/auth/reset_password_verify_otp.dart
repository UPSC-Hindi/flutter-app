import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/screen/auth/create_password_screen.dart';
import 'package:upsc_web/utils/color_resources.dart';
import 'package:upsc_web/utils/utils.dart';

class ResetPasswordVerifyOtp extends StatefulWidget {
  const ResetPasswordVerifyOtp({Key? key, required this.email_phoneNumber})
      : super(key: key);
  final String email_phoneNumber;

  @override
  State<ResetPasswordVerifyOtp> createState() => _ResetPasswordVerifyOtpState();
}

class _ResetPasswordVerifyOtpState extends State<ResetPasswordVerifyOtp> {
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);

  final controller = TextEditingController();
  final focusNode = FocusNode();
  String otp = '';
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: GoogleFonts.notoSansDevanagari(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuth) {
          Utils.showLoading(context);
        }
        if (state is ErrorAuth) {
          Utils.hideLoading(context);
        }
        if (state is ResetPasswordOtpSuccess) {
          Utils.hideLoading(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreatePasswordScreen(
                email_phoneNumber: widget.email_phoneNumber,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter OTP',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sent on ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.email_phoneNumber,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorResources.buttoncolor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        ' Change ',
                        style: GoogleFonts.notoSansDevanagari(
                          fontSize: 14,
                          color: ColorResources.buttoncolor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Pinput(
                  length: 4,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  onCompleted: (pin) {
                    otp = pin;
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
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  decoration: BoxDecoration(
                      color: ColorResources.buttoncolor,
                      borderRadius: BorderRadius.circular(14)),
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).resetPasswordOtp(
                          widget.email_phoneNumber, controller.text);
                    },
                    child: Text(
                      'Verify',
                      style: GoogleFonts.notoSansDevanagari(
                        color: ColorResources.textWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Did not recieve the code?'),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).resendPasswordOtp(
                          widget.email_phoneNumber,
                        );
                      },
                      child: Text(
                        ' Try again',
                        style: GoogleFonts.notoSansDevanagari(
                            color: ColorResources.buttoncolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
