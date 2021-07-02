import 'package:flutter/material.dart';

class AnnotationPainter extends CustomPainter {
  final BuildContext context;

  AnnotationPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    // canvas.drawRect(rect, Paint()..color = Color.fromRGBO(0, 255, 0, 0.2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
