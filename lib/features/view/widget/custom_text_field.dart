

import 'package:flutter/material.dart';

class CustomTextFilled extends StatelessWidget {
  const CustomTextFilled({Key? key, required this.hintText}) : super(key: key);
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}


class PasswordTextFilled extends StatefulWidget {
  const PasswordTextFilled({Key? key}) : super(key: key);

  @override
  State<PasswordTextFilled> createState() => _PasswordTextFilledState();
}

class _PasswordTextFilledState extends State<PasswordTextFilled> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: _isVisible,
        decoration: InputDecoration(
          hintText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                _isVisible = !_isVisible;
              });
            },
              child: _isVisible?const Icon(Icons.visibility_off):const Icon(Icons.visibility)),
        ),
      ),
    );
  }
}
