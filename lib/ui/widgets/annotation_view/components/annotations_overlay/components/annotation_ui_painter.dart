import 'package:flutter/material.dart';
import 'package:klint/state/ui/mouse_state.dart';

class AnnotationUIPainter extends CustomPainter {
  final MouseState mouseState;
  final Paint guideLinePaint = Paint()..color = Colors.grey.shade400;

  AnnotationUIPainter(this.mouseState) : super(repaint: mouseState);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(mouseState.position.dx, 0), Offset(mouseState.position.dx, size.height), guideLinePaint);
    canvas.drawLine(Offset(0, mouseState.position.dy), Offset(size.width, mouseState.position.dy), guideLinePaint);
  }

  @override
  bool shouldRepaint(covariant AnnotationUIPainter oldDelegate) => true;
}
