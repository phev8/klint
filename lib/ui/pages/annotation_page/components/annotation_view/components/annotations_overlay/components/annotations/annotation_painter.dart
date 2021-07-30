import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class AnnotationPainter extends CustomPainter {
  final BuildContext context;
  static double strokeWidth = 4;
  static double outlineWidth = 1;
  static double touchTargetExtension = 8;

  static double selectedWidth = strokeWidth + outlineWidth * 2;
  static double touchWidth = selectedWidth + 2 * touchTargetExtension;

  late MarkingDataState markingDataState;
  late AnnotationState annotationState;

  AnnotationPainter(this.context) {
    //context = _context;
    markingDataState = context.read<MarkingDataState>();
    annotationState = context.read<AnnotationState>();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);
    var boxMarkings = markingDataState.markingData?.boxMarkings;
    var selectedBoxes = annotationState.selectedBoxMarkings;

    if (boxMarkings != null) {
      boxMarkings.asMap().forEach((index, boxMarking) {
        Rect rect = Rect.fromPoints(
            Offset(size.width * boxMarking.first[0],
                size.height * boxMarking.first[1]),
            Offset(size.width * boxMarking.second[0],
                size.height * boxMarking.second[1]));
        paintBoxMarking(touchyCanvas, rect, selectedBoxes.contains(index),
            index, size, annotationState.borderSelection);
      });
    }
  }

  void paintBoxMarking(TouchyCanvas canvas, Rect rect, bool selected, int index,
      Size size, bool borderSelection) {
    var boxMarkings = context.read<MarkingDataState>().markingData?.boxMarkings;
    var markingClass = context
        .read<ProjectState>()
        .project
        ?.classes
        .where((element) => element.classID == boxMarkings![index].classID)
        .first;

    var classColor = Color.fromARGB(255, 127, 127, 127);
    if (markingClass?.argb.length == 4) {
      classColor = Color.fromARGB(
          markingClass!.argb[0] as int,
          markingClass.argb[1] as int,
          markingClass.argb[2] as int,
          markingClass.argb[3] as int);
    }
    const classLabelFontSize = 11.0;
    const classLabelPadding = 2.0;
    var style = TextStyle(
        fontSize: classLabelFontSize,
        height: 1.0,
        color: Colors.white,
        fontWeight: FontWeight.normal);

    //var classLabel = "Class Label";
    //classLabel = boxMarkings?.elementAt(index).classID as String;

    final ParagraphBuilder paragraphBuilder =
        ParagraphBuilder(style.getParagraphStyle())
          ..pushStyle(style.getTextStyle())
          ..addText(markingClass!.defaultTitle);
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: rect.width - classLabelPadding * 2));
    paragraph.layout(ParagraphConstraints(
        width: paragraph.computeLineMetrics().first.width +
            classLabelPadding * 2));
    canvas.drawRect(
        Rect.fromLTWH(
            rect.left - strokeWidth / 2,
            rect.top -
                paragraph.height -
                classLabelPadding -
                (strokeWidth + outlineWidth),
            paragraph.width + classLabelPadding * 2,
            paragraph.height +
                classLabelPadding +
                (strokeWidth + outlineWidth)),
        Paint()
          ..color = classColor
          ..style = PaintingStyle.fill);
    canvas.drawParagraph(
        paragraph,
        Offset(
            rect.left + classLabelPadding,
            rect.top -
                (paragraph.height + strokeWidth + outlineWidth) +
                classLabelPadding));

    canvas.drawRect(
      rect,
      Paint()
        ..color = (selected ? Colors.white12 : Colors.transparent)
        ..style = (borderSelection ? PaintingStyle.stroke : PaintingStyle.fill)
        ..strokeWidth = touchWidth,
      onTapDown: (tapDetail) {
        print('Touched / clicked box number $index');
        context.read<AnnotationState>().selectedBoxMarkings = [index];
      },
      onPanUpdate: (details) {
        //print("onPanUpdate");
        if (selected) {
          boxMarkings?.elementAt(index).first[0] +=
              (details.delta.dx / size.width);
          boxMarkings?.elementAt(index).first[1] +=
              (details.delta.dy / size.height);
          boxMarkings?.elementAt(index).second[0] +=
              (details.delta.dx / size.width);
          boxMarkings?.elementAt(index).second[1] +=
              (details.delta.dy / size.height);
        }
      },
      onPanDown: (details) {
        print("onPanDown");
        //print(details);
      },
      onPanStart: (details) {
        print("onPanStart");

        //print(details);
      },
      onTapUp: (details) {
        print("onTapUp");
      },
    );
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
          ..color = classColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
