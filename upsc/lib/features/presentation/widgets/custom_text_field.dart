import 'package:flutter/material.dart';

class CustomTextFilled extends StatelessWidget {
  const CustomTextFilled({Key? key, required this.hintText, required this.textController, required this.validator}) : super(key: key);
  final String hintText;
  final TextEditingController textController;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}


class PasswordTextFilled extends StatefulWidget {
  const PasswordTextFilled({Key? key, required this.textEditingController, required this.validator}) : super(key: key);
  final TextEditingController textEditingController;
  final FormFieldValidator<String> validator;
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
        controller: widget.textEditingController,
        obscureText: _isVisible,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                _isVisible = !_isVisible;
              });
            },
              child: _isVisible?Icon(Icons.visibility_off):Icon(Icons.visibility)),
        ),
      ),
    );
  }
}
