import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc/features/cubit/auth/auth_cubit.dart';
import 'package:upsc/features/presentation/widgets/auth_button.dart';
import 'package:upsc/features/presentation/widgets/custom_text_field.dart';
import 'package:upsc/features/presentation/widgets/tostmessage.dart';
import 'package:upsc/util/color_resources.dart';
import 'package:upsc/util/prefConstatnt.dart';
import 'package:upsc/view/screens/auth/sign_in_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key, required this.email_phoneNumber})
      : super(key: key);
  final String email_phoneNumber;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is UpdatePasswordLoading) {
            Preferences.onLoading(context);
          }
          if (state is UpdatePasswordError) {
            Preferences.hideDialog(context);
          }
          if (state is UpdatePasswordSuccess) {
            Preferences.hideDialog(context);
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            });
          }
        },
        builder: (context, state) {
          if (state is UpdatePasswordSuccess) {
            return Center(
              child: Icon(
                Icons.verified,
                size: 200,
                color: ColorResources.buttoncolor,
              ),
            );
          }
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
                    onChanged: (value) => _formKey.currentState!.validate(),
                    hintText: 'New Password',
                    textController: passwordController,
                    validator: ValidationBuilder()
                        .required()
                        .minLength(8)
                        .regExp(
                            RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                            'valid password ex:Testing@1')
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFilled(
                    onChanged: (value) => _formKey.currentState!.validate(),
                    hintText: 'Conform Password ',
                    textController: conformPasswordController,
                    validator: ValidationBuilder()
                        .required()
                        .minLength(8)
                        .regExp(
                            RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
                            'valid password ex:Testing@1')
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 60),
                  AuthButton(
                    text: 'Set and Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          passwordController.text ==
                              conformPasswordController.text) {
                        BlocProvider.of<AuthCubit>(context).updatePassword({
                          'NewPassword': passwordController.text,
                          'ConfirmPassword': conformPasswordController.text,
                          'email_phoneNumber': widget.email_phoneNumber,
                        });
                      } else {
                        flutterToast('Enter same password');
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
