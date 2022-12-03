
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({Key? key, required this.mobile, required this.web}) : super(key: key);
  final Widget mobile;
  final Widget web;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth<600){
        return mobile;
      }
      return web;
    });
  }
}
