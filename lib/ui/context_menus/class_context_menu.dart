import 'package:flutter/material.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/api/entities/project.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/ui/context_menus/context_menu.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/section_title_item.dart';
import 'package:tuple/tuple.dart';
import 'package:provider/provider.dart';

import 'context_menu_items/items/single_choice_item/single_choice_item.dart';
import 'context_menu_items/items/spacing_item.dart';
import 'context_menu_items/items/title_item.dart';

class ClassContextMenu extends ContextMenu {
  final BuildContext _context;

  ClassContextMenu._(this._context, List<ContextMenuItem> items) : super(items);

  @override
  onOpen() {
    _context.read<AnnotationBarState>().classes = true;
  }

  @override
  onClose() {
    _context.read<AnnotationBarState>().classes = false;
  }

  factory ClassContextMenu(
      BuildContext context, ProjectState projectState, MarkingDataState markingDataState, AnnotationState annotationState) {
    List<ContextMenuItem> items;
    //print("Building ClassContextMenu");
    if ((projectState.projectKey != "" && projectState.project == null) || markingDataState.markingData == null) {
      items = [SectionTitleItem("Loading")];
    } else if (projectState.project == null || projectState.project!.classes.length == 0) {
      items = [SectionTitleItem("No Classes")];
    } else {
      var createClassItem = (Project project) {
        List<Tuple2<String, String>> options = [];
        for (var c in project.classes) {
          if (c.scope == MarkingScope.OBJECTS) {
            options.add(new Tuple2(c.classID, c.defaultTitle));
          }
        }

        var currentClass;

        try {
          //print(annotationState.selectedBoxMarkings.length);
          if (annotationState.selectedBoxMarkings.length == 1) {
            currentClass = markingDataState.markingData!.boxMarkings[annotationState.selectedBoxMarkings.first].classID;
          } else if (annotationState.selectedBoxMarkings.length > 1) {
            var classesSet = <String>{};
            for (var index in annotationState.selectedBoxMarkings) {
              classesSet.add(markingDataState.markingData!.boxMarkings[index].classID);
            }
            if (classesSet.length == 1) {
              currentClass = classesSet.first;
            }
          }
        } catch (e) {
          print(e);
        }

        return SingleChoiceItem("Objects", options, currentClass, (value) {
          if (annotationState.selectedBoxMarkings.isNotEmpty) {
            for (var index in annotationState.selectedBoxMarkings) {
              if (value != null) {
                markingDataState.markingData!.boxMarkings[index].classID = value;
              } else {
                markingDataState.markingData!.boxMarkings[index].classID = "";
              }
            }
          }
        });
      };

      items = [
        TitleItem("Classes"),
        SpacingItem(
          factor: 2.0,
        ),
        createClassItem(projectState.project!),
      ];
    }

    return ClassContextMenu._(context, items);
  }
}
