import 'package:flutter/material.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:provider/provider.dart';

class AnnotationPainter extends CustomPainter {
  final BuildContext context;

  AnnotationPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    // canvas.drawRect(rect, Paint()..color = Color.fromRGBO(0, 255, 0, 0.2));
    var boxMarkings = context.read<MarkingDataState>().markingData?.boxMarkings;

    if (boxMarkings != null) {
      boxMarkings.forEach((boxMarking) {
        Rect rect = Rect.fromPoints(
            Offset(size.width / boxMarking.first[0] * 40, size.height / boxMarking.first[1] * 40),
            Offset(size.width / boxMarking.second[0] * 40, size.height / boxMarking.second[1] * 40));
        canvas.drawRect(
            rect,
            Paint()
              ..color = Colors.red
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
