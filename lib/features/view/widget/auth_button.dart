import 'package:flutter/material.dart';
import 'package:upsc_web/utils.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.text, required this.onPressed}) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250,minWidth: 250,minHeight: 44),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Util.buttonColor,
          borderRadius: BorderRadius.circular(14)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: Util.whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: 20
          ),
        ),
      ),
    );
  }
}
