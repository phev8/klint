import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import 'annotation_painter.dart';

class Annotations extends StatelessWidget {
  final Widget? frame;

  Annotations(this.frame);

  @override
  Widget build(BuildContext context) {
    return CanvasTouchDetector(
        builder: (context) => CustomPaint(
              foregroundPainter: AnnotationPainter(context),
              child: frame,
            ));
  }
}
