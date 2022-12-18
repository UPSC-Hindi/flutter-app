import 'package:flutter/material.dart';
import 'package:upsc_web/utils/color_resources.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    // Path number 1
    paint.color = ColorResources.buttoncolor;
    path = Path();
    path.lineTo(size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, size.height * 0.76, 0, size.height * 0.76);
    path.cubicTo(size.width / 4, size.height * 1.1, size.width * 0.79,
        size.height * 1.05, size.width, size.height * 0.76);
    path.cubicTo(size.width, size.height * 0.76, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, 0, size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
