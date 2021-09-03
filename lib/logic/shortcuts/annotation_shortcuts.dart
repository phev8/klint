import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/api/entities/marking_data.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/ui/context_menus/tag_context_menu.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  TagContextMenu _tagContextMenu;

  AnnotationShortcuts(this._tagContextMenu);

  _setAnnotationMode(BuildContext context, AnnotationMode newMode) {
    context.read<AnnotationState>().mode = newMode;
    context.read<AnnotationBarState>().setAnnotationMode(newMode);
  }

  @override
  onKey(context, event) {
    ContextMenuState contextMenuState = context.read<ContextMenuState>();
    AnnotationState annotationState = context.read<AnnotationState>();
    AnnotationBarState annotationBarState = context.read<AnnotationBarState>();
    MarkingDataState markingDataState = context.read<MarkingDataState>();

    //  T
    if (event.isKeyPressed(LogicalKeyboardKey.keyT)) {
      if (!(contextMenuState.contextMenus.isNotEmpty && contextMenuState.contextMenus.last is TagContextMenu)) {
        contextMenuState.closeContextMenu();
        contextMenuState.openContextMenu(_tagContextMenu);
      } else {
        contextMenuState.closeContextMenu();
      }
      return true;
      //  S
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
      context.read<MarkingDataState>().saveToServer();
      //  B
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyB)) {
      if (contextMenuState.contextMenus.isNotEmpty) {
        contextMenuState.closeContextMenu();
        _setAnnotationMode(context, AnnotationMode.BOX);
      } else {
        if (annotationState.mode == AnnotationMode.BOX) {
          _setAnnotationMode(context, AnnotationMode.NONE);
        } else {
          _setAnnotationMode(context, AnnotationMode.BOX);
        }
      }
      //  D
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyD) && annotationState.hasSelections()) {
      if (annotationState.mode == AnnotationMode.DELETE) {
        _setAnnotationMode(context, AnnotationMode.NONE);
        List<int> selectedBoxesAscending = annotationState.selectedBoxMarkings.toList();
        selectedBoxesAscending.sort();
        selectedBoxesAscending = new List.from(selectedBoxesAscending.reversed);
        for (var index in selectedBoxesAscending) {
          markingDataState.markingData?.boxMarkings.removeAt(index);
        }
        annotationState.emptySelection();
        print(annotationState.mode);
      } else if (contextMenuState.contextMenus.isNotEmpty) {
        contextMenuState.closeContextMenu();
        _setAnnotationMode(context, AnnotationMode.DELETE);
      } else {
        _setAnnotationMode(context, AnnotationMode.DELETE);
      }
    }
    annotationState.additionalSelection = event.isShiftPressed;
    annotationState.borderSelection = event.isAltPressed;
    annotationBarState.setAnnotationMode(annotationState.mode);
    return false;
  }
}
