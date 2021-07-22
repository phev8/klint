import 'package:flutter/material.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class AnnotationPainter extends CustomPainter {
  final BuildContext context;
  static double strokeWidth = 4;
  static double outlineWidth = 1;
  static double touchTargetExtension = 8;

  static double selectedWidth = strokeWidth + outlineWidth * 2;
  static double touchWidth = selectedWidth + 2 * touchTargetExtension;

  AnnotationPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);
    var boxMarkings = context.read<MarkingDataState>().markingData?.boxMarkings;
    var selectedBoxes = context.read<AnnotationState>().selectedBoxMarkings;

    if (boxMarkings != null) {
      boxMarkings.asMap().forEach((index, boxMarking) {
        Rect rect = Rect.fromPoints(
            Offset(size.width * boxMarking.first[0],
                size.height * boxMarking.first[1]),
            Offset(size.width * boxMarking.second[0],
                size.height * boxMarking.second[1]));
        paintBoxMarking(
            touchyCanvas, rect, selectedBoxes.contains(index), index);
      });
    }
  }

  void paintBoxMarking(
      TouchyCanvas canvas, Rect rect, bool selected, int index) {
    if (selected) {
      // If selected, draw outline first
      canvas.drawRect(
          rect,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = selectedWidth);
    }
    canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
    canvas.drawRect(
        rect,
        Paint()
          ..color = (selected ? Colors.transparent : Colors.transparent)
          ..style = PaintingStyle.stroke
          ..strokeWidth = touchWidth, onTapDown: (tapDetail) {
      print('Touched / clicked box number $index');
      context.read<AnnotationState>().selectedBoxMarkings = [index];
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
