import 'package:flutter/material.dart';

import 'annotation_painter.dart';

class Annotations extends StatelessWidget {
  final Widget? frame;

  Annotations(this.frame);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnnotationPainter(context),
      child: frame,
    );
  }
}
