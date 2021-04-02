import 'package:flutter/material.dart';

import 'components/annotation_painter.dart';
import 'components/frame/frame.dart';

class AnnotationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnnotationPainter(),
      child: Frame(),
    );
  }
}
