import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc/features/cubit/auth/auth_cubit.dart';
import 'package:upsc/features/presentation/widgets/auth_button.dart';
import 'package:upsc/features/presentation/widgets/custom_text_field.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/auth/reset_password_verify_otp.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoadingAuth) {
            Preferences.onLoading(context);
          }
          if (state is ErrorAuth) {
            Preferences.hideDialog(context);
          }
          if (state is ResetPasswordSuccess) {
            Preferences.hideDialog(context);
            Preferences.hideDialog(context);
            if (mobileController.text.isNotEmpty &&
                mobileController.text.length == 10) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ResetPasswordVerifyOtp(
                      email_phoneNumber: mobileController.text),
                ),
              );
            } else if (emailController.text.isNotEmpty) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ResetPasswordVerifyOtp(
                      email_phoneNumber: emailController.text),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 60),
                  CustomTextFilled(
                    onChanged: (value) =>
                      _formKey.currentState!.validate(),
                    hintText: 'Mobile No.',
                    textController: mobileController,
                    validator: ValidationBuilder()
                        .required()
                        .phone()
                        .maxLength(10)
                        .minLength(10)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Or'),
                  const SizedBox(height: 20),
                  CustomTextFilled(
                    onChanged: (value) =>
                      _formKey.currentState!.validate(),
                    hintText: 'Email ',
                    textController: emailController,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 60),
                  AuthButton(
                    text: 'Send OTP',
                    onPressed: () {
                      if (mobileController.text.isNotEmpty &&
                          mobileController.text.length == 10) {
                        BlocProvider.of<AuthCubit>(context)
                            .resetPassword(mobileController.text);
                      } else if (emailController.text.isNotEmpty) {
                        BlocProvider.of<AuthCubit>(context)
                            .resetPassword(emailController.text);
                      } else {
                        flutterToast('Enter valid data');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}