import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/api/entities/box_marking.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/api/entities/marking_class.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class AnnotationPainter extends CustomPainter {
  final BuildContext context;
  static double strokeWidth = 4;
  static double outlineWidth = 1;
  static double touchTargetExtension = 8;
  static double resizeTargetRadius = 8;
  static double resizeTargetRadiusSmall = 4;

  static double selectedWidth = strokeWidth + outlineWidth * 2;
  static double touchWidth = selectedWidth + 2 * touchTargetExtension;

  late MarkingDataState markingDataState;
  late AnnotationState annotationState;
  late AnnotationBarState annotationBarState;
  late MouseState mouseState;

  AnnotationPainter(this.context) {
    //context = _context;
    markingDataState = context.read<MarkingDataState>();
    annotationState = context.read<AnnotationState>();
    annotationBarState = context.read<AnnotationBarState>();
    mouseState = context.read<MouseState>();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);
    var boxMarkings = markingDataState.markingData?.boxMarkings;
    var selectedBoxes = annotationState.selectedBoxMarkings;

    paintDeselectionRect(touchyCanvas, size);
    if (boxMarkings != null) {
      boxMarkings.asMap().forEach((index, boxMarking) {
        Rect rect = Rect.fromPoints(Offset(size.width * boxMarking.first[0], size.height * boxMarking.first[1]),
            Offset(size.width * boxMarking.second[0], size.height * boxMarking.second[1]));
        paintBoxMarking(touchyCanvas, rect, selectedBoxes.contains(index), index, size, annotationState.borderSelection);
        if (selectedBoxes.contains(index) && !annotationState.isPanning && !(annotationState.selectedBoxMarkings.length > 1)) {
          paintResizeTargets(touchyCanvas, rect, index);
        }
      });

      paintPanningRect(touchyCanvas, size, boxMarkings, selectedBoxes);
    }
  }

  void paintDeselectionRect(TouchyCanvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint()
        ..color = (Colors.transparent)
        ..style = (PaintingStyle.fill),
      onPanStart: (details) {
        annotationState.emptySelection();
        if (annotationState.mode == AnnotationMode.BOX) {
          var position1 = [details.localPosition.dx / size.width, details.localPosition.dy / size.height];
          var position2 = [(details.localPosition.dx) / size.width, (details.localPosition.dy) / size.height];
          markingDataState.markingData!.boxMarkings.add(new BoxMarking("undefined", position1, position2));
          //markingDataState.markingData!.boxMarkings.last.first = position1;
          //markingDataState.markingData!.boxMarkings.last.second = position2;
          annotationState.selectedBoxMarkings = new Set<int>.from([markingDataState.markingData!.boxMarkings.length - 1]);
          annotationState.isCreating = true;
        }
      },
      onPanUpdate: (details) {},
      onTapUp: (details) {
        annotationState.emptySelection();
        annotationState.mode = AnnotationMode.NONE;
        annotationBarState.setAnnotationMode(annotationState.mode);
      },
    );
  }

  void paintPanningRect(TouchyCanvas canvas, Size size, List<BoxMarking> boxMarkings, Set<int> selectedBoxes) {
    if (annotationState.isPanning || annotationState.isResizing || annotationState.isCreating) {
      canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height),
        Paint()
          ..color = (Colors.transparent)
          ..style = (PaintingStyle.fill),
        onPanUpdate: (details) {
          //print("onPanUpdate");
          if (annotationState.isPanning) {
            mouseState.cursor = SystemMouseCursors.grabbing;
            for (var selectedBoxIndex in selectedBoxes) {
              boxMarkings.elementAt(selectedBoxIndex).first[0] += (details.delta.dx / size.width);
              boxMarkings.elementAt(selectedBoxIndex).first[1] += (details.delta.dy / size.height);
              boxMarkings.elementAt(selectedBoxIndex).second[0] += (details.delta.dx / size.width);
              boxMarkings.elementAt(selectedBoxIndex).second[1] += (details.delta.dy / size.height);
            }
            if (annotationState.mode == AnnotationMode.DELETE) {
              annotationState.mode = AnnotationMode.NONE;
              annotationBarState.setAnnotationMode(annotationState.mode);
            }
          } else if (annotationState.isResizing) {
            mouseState.cursor = SystemMouseCursors.move;
            int selectedBoxIndex = selectedBoxes.first;
            BoxMarking boxMarking = boxMarkings.elementAt(selectedBoxIndex);
            Rect boxRect =
                Rect.fromPoints(Offset(boxMarking.first[0], boxMarking.first[1]), Offset(boxMarking.second[0], boxMarking.second[1]));
            boxRect = applyRectDelta(
                boxRect, Offset(details.delta.dx / size.width, details.delta.dy / size.height), annotationState.resizingEdgesLTRB);
            boxMarkings.elementAt(selectedBoxIndex).first = [boxRect.topLeft.dx, boxRect.topLeft.dy];
            boxMarkings.elementAt(selectedBoxIndex).second = [boxRect.bottomRight.dx, boxRect.bottomRight.dy];
          } else if (annotationState.isCreating) {
            mouseState.cursor = SystemMouseCursors.move;
            int selectedBoxIndex = selectedBoxes.first;
            Offset secondPoint = Offset(details.localPosition.dx / size.width, details.localPosition.dy / size.height);
            boxMarkings.elementAt(selectedBoxIndex).second = [secondPoint.dx, secondPoint.dy];
          }
        },
        onTapUp: (details) {
          // TODO: Make these exclusive from each other!
          annotationState.isPanning = false;
          annotationState.isResizing = false;
          annotationState.isCreating = false;
          annotationState.emptySelection();
          mouseState.cursor = SystemMouseCursors.precise;
        },
      );
    }
  }

  void paintBoxMarking(TouchyCanvas canvas, Rect rect, bool selected, int index, Size size, bool borderSelection) {
    const classLabelFontSize = 11.0;
    const classLabelPadding = 2.0;
    var classColor = Color.fromARGB(255, 127, 127, 127);
    var boxMarkings = context.read<MarkingDataState>().markingData?.boxMarkings;
    var markingClass = new MarkingClass("undefined", "undefined", MarkingScope.OBJECTS, [255, 127, 127, 127]);

    try {
      var classLookup =
          context.read<ProjectState>().project?.classes.where((element) => element.classID == boxMarkings![index].classID).first;
      if (classLookup != null) {
        markingClass = classLookup;
      }
    } catch (e) {}

    if (markingClass.argb.length == 4) {
      classColor = Color.fromARGB(
          markingClass.argb[0] as int, markingClass.argb[1] as int, markingClass.argb[2] as int, markingClass.argb[3] as int);
    }

    var style = TextStyle(fontSize: classLabelFontSize, height: 1.0, color: Colors.white, fontWeight: FontWeight.normal);
    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(style.getParagraphStyle())
      ..pushStyle(style.getTextStyle())
      ..addText(markingClass.defaultTitle);
    double relevantWidth = rect.width;
    if (rect.width < 64) {
      relevantWidth = 64;
    }
    final Paragraph paragraph = paragraphBuilder.build()..layout(ParagraphConstraints(width: relevantWidth - classLabelPadding * 2));
    paragraph.layout(ParagraphConstraints(width: paragraph.computeLineMetrics().first.width + classLabelPadding * 2));
    Rect classLabelRect = Rect.fromLTWH(
        rect.left - strokeWidth / 2,
        rect.top - paragraph.height - classLabelPadding - (strokeWidth + outlineWidth),
        paragraph.width + classLabelPadding * 2,
        paragraph.height + classLabelPadding + (strokeWidth + outlineWidth));
    canvas.drawRect(
        classLabelRect,
        Paint()
          ..color = classColor
          ..style = PaintingStyle.fill);
    canvas.drawParagraph(
        paragraph, Offset(rect.left + classLabelPadding, rect.top - (paragraph.height + strokeWidth + outlineWidth) + classLabelPadding));

    canvas.drawRect(
      rect,
      Paint()
        ..color = (selected
            ? (annotationState.mode == AnnotationMode.DELETE ? Color.fromRGBO(255, 0, 0, 0.5) : Colors.white24)
            : Colors.transparent)
        ..style = (borderSelection ? PaintingStyle.stroke : PaintingStyle.fill)
        ..strokeWidth = touchWidth,
      onTapUp: (tapDetail) {
        var selections = new Set<int>.from(annotationState.selectedBoxMarkings);
        if (annotationState.isAdditionalSelection) {
          selections.add(index);
        } else {
          selections = new Set<int>.from([index]);
        }
        annotationState.selectedBoxMarkings = selections;
        if (annotationState.mode == AnnotationMode.DELETE) {
          annotationState.mode = AnnotationMode.NONE;
          annotationBarState.setAnnotationMode(annotationState.mode);
        }
      },
      onPanUpdate: (details) {
        //print("onPanUpdate");
      },
      onPanDown: (details) {
        //print("onPanDown");
        //print(details);
      },
      onPanStart: (details) {
        //print("onPanStart");
        //print(details);
        if (selected) {
          //annotationState.selectedBoxMarkings.add(index);
          annotationState.isPanning = true;
        }
      },
      onTapDown: (details) {
        //print("onTapDown");
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

  void paintResizeTargets(TouchyCanvas canvas, Rect rect, int index) {
    double radius = resizeTargetRadius;
    double upperScaleLimit = 200;
    double lowerScaleLimit = 50;
    double referenceValue = [rect.height, rect.width].reduce(min);
    if (referenceValue < upperScaleLimit) {
      if (referenceValue < lowerScaleLimit) {
        referenceValue = lowerScaleLimit;
      }
      radius = lerpDouble(
          resizeTargetRadiusSmall, resizeTargetRadius, ((referenceValue - lowerScaleLimit) / (upperScaleLimit - lowerScaleLimit)))!;
    }
    paintResizeTarget(canvas, rect.bottomRight, radius, [false, false, true, true]);
    paintResizeTarget(canvas, rect.bottomLeft, radius, [true, false, false, true]);
    paintResizeTarget(canvas, rect.topLeft, radius, [true, true, false, false]);
    paintResizeTarget(canvas, rect.topRight, radius, [false, true, true, false]);

    paintResizeTarget(canvas, rect.bottomCenter, radius, [false, false, false, true]);
    paintResizeTarget(canvas, rect.topCenter, radius, [false, true, false, false]);
    paintResizeTarget(canvas, rect.centerRight, radius, [false, false, true, false]);
    paintResizeTarget(canvas, rect.centerLeft, radius, [true, false, false, false]);
  }

  void paintResizeTarget(TouchyCanvas canvas, Offset center, double radius, List<bool> edgesLTRB) {
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill, onPanUpdate: (details) {
      annotationState.isResizing = true;
      annotationState.resizingEdgesLTRB = edgesLTRB;
    });
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke);
  }

  Rect applyRectDelta(Rect rect, Offset delta, List<bool> edgesLTRB) {
    Rect newRect = rect;
    if (edgesLTRB[0] == true) {
      newRect = Rect.fromLTRB(newRect.left + delta.dx, newRect.top, newRect.right, newRect.bottom);
    }
    if (edgesLTRB[1] == true) {
      newRect = Rect.fromLTRB(newRect.left, newRect.top + delta.dy, newRect.right, newRect.bottom);
    }
    if (edgesLTRB[2] == true) {
      newRect = Rect.fromLTRB(newRect.left, newRect.top, newRect.right + delta.dx, newRect.bottom);
    }
    if (edgesLTRB[3] == true) {
      newRect = Rect.fromLTRB(newRect.left, newRect.top, newRect.right, newRect.bottom + delta.dy);
    }
    if (!annotationState.isCreating && (newRect.width < 0.015 || newRect.height < 0.015)) {
      return rect;
    } else {
      return newRect;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
