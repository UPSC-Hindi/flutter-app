import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:upsc_web/app_route.dart';
import 'package:upsc_web/features/view/cubit/auth/auth_cubit.dart';
import 'package:upsc_web/features/view/screen/auth/sign_in_screen.dart';
import 'package:upsc_web/features/view/widget/auth_button.dart';
import 'package:upsc_web/features/view/widget/custom_text_field.dart';
import 'package:upsc_web/utils/utils.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key, required this.email_phoneNumber}) : super(key: key);
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
          if (state is LoadingAuth) {
            Utils.showLoading(context);
          }
          if (state is ErrorAuth) {
            Utils.hideLoading(context);
            Utils.hideLoading(context);
          }
          if (state is UpdatePasswordSuccess) {
            Utils.hideLoading(context);
            Navigator.popAndPushNamed(context, AppRoute.signInScreen);
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
                    text: 'Send OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          passwordController.text ==
                              conformPasswordController.text) {
                        BlocProvider.of<AuthCubit>(context).updatePassword({
                          'NewPassword': passwordController.text,
                          'ConfirmPassword': conformPasswordController.text,
                          'email_phoneNumber':widget.email_phoneNumber,
                        });
                      } else {
                        Utils.toastMessage('Enter same password');
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