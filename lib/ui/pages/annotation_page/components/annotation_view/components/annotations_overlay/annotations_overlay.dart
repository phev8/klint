import 'package:flutter/material.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:klint/ui/widgets/mouse_provider.dart';
import 'package:provider/provider.dart';

import 'components/annotation_ui_painter.dart';
import 'components/annotations/annotations.dart';

class AnnotationsOverlay extends StatelessWidget {
  final Widget? frame;

  const AnnotationsOverlay({Key? key, this.frame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnnotationUIPainter(Provider.of<MouseState>(context, listen: false)),
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: MouseProvider(
            child: Annotations(frame),
          ),
        ),
      ),
    );
  }
}
