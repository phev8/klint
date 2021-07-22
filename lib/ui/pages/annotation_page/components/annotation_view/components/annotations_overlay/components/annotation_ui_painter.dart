import 'package:flutter/material.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class AnnotationUIPainter extends CustomPainter {
  final MouseState mouseState;
  final AnnotationState annotationState;

  AnnotationUIPainter(this.mouseState, this.annotationState)
      : super(repaint: Listenable.merge([mouseState, annotationState]));

  @override
  void paint(Canvas canvas, Size size) {
    if (mouseState.isPresent) {
      canvas.drawLine(
        Offset(mouseState.position.dx, 0),
        Offset(mouseState.position.dx, size.height),
        KlintThemeData.guideLinePaint,
      );
      canvas.drawLine(
        Offset(0, mouseState.position.dy),
        Offset(size.width, mouseState.position.dy),
        KlintThemeData.guideLinePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AnnotationUIPainter oldDelegate) => true;
}
