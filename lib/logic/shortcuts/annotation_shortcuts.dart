import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/persistent/annotation_screen_state.dart';
import 'package:klint/state/ui/annotation_bar_state.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';
import 'package:klint/state/ui/annotation_state/annotation_state.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/ui/context_menus/class_context_menu.dart';
import 'package:klint/ui/context_menus/tag_context_menu.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  final BuildContext _context;

  TagContextMenu _tagContextMenu;
  ClassContextMenu _classContextMenu;

  late List<String> mediaKeys = _context.read<MarkingDataState>().mediaKeys;

  AnnotationShortcuts(this._context, this._tagContextMenu, this._classContextMenu) {
    /*     AnnotationScreenState appState = _context.read<AnnotationScreenState>();
    Api.call(_context, () => ProjectsApi.getAllProjectFiles(appState.projectKey, appState.mediaCollection.id), onSuccess: (response) {
      var result = jsonDecode(response.data.toString());
      mediaKeys = result;
    }); */
  }

  _setAnnotationMode(BuildContext context, AnnotationMode newMode) {
    context.read<AnnotationState>().mode = newMode;
    context.read<AnnotationBarState>().setAnnotationMode(newMode);
  }

  Future _asyncInputDialog(
      BuildContext context, AnnotationScreenState appState, AnnotationState annotationState, AnnotationBarState annotationBarState) async {
    String input = '';
    return showDialog(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Jump to Image'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                autofocus: false,
                decoration: new InputDecoration(helperText: 'file name / frame', hintText: 'img0.jpg'),
                onChanged: (value) {
                  input = value;
                },
              ))
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(input);
                if (input.length > 0) {
                  int currentIndex = mediaKeys.indexOf(input);
                  if (currentIndex >= 0) {
                    appState.mediaKey = mediaKeys[currentIndex];
                    //TODO: Fix this workaround.
                    annotationBarState.setAnnotationMode(annotationState.mode);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  onKey(context, event) {
    ContextMenuState contextMenuState = context.read<ContextMenuState>();
    AnnotationState annotationState = context.read<AnnotationState>();
    AnnotationBarState annotationBarState = context.read<AnnotationBarState>();
    MarkingDataState markingDataState = context.read<MarkingDataState>();
    AnnotationScreenState appState = context.read<AnnotationScreenState>();

    //  T
    if (event.isKeyPressed(LogicalKeyboardKey.keyT)) {
      if (!(contextMenuState.contextMenus.isNotEmpty && contextMenuState.contextMenus.last is TagContextMenu)) {
        contextMenuState.closeContextMenu();
        contextMenuState.openContextMenu(_tagContextMenu);
      } else {
        contextMenuState.closeContextMenu();
      }
      // C
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyC)) {
      if ((!(contextMenuState.contextMenus.isNotEmpty && contextMenuState.contextMenus.last is ClassContextMenu)) &&
          annotationState.selectedBoxMarkings.isNotEmpty) {
        contextMenuState.closeContextMenu();
        contextMenuState.openContextMenu(_classContextMenu);
      } else {
        contextMenuState.closeContextMenu();
      }

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
        //print(annotationState.mode);
      } else if (contextMenuState.contextMenus.isNotEmpty) {
        contextMenuState.closeContextMenu();
        _setAnnotationMode(context, AnnotationMode.DELETE);
      } else {
        _setAnnotationMode(context, AnnotationMode.DELETE);
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      int currentIndex = mediaKeys.indexOf(appState.mediaKey);
      if (mediaKeys.length - 1 > currentIndex) {
        currentIndex++;
        appState.mediaKey = mediaKeys[currentIndex];
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      int currentIndex = mediaKeys.indexOf(appState.mediaKey);
      if (currentIndex >= 1) {
        currentIndex--;
        appState.mediaKey = mediaKeys[currentIndex];
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyJ)) {
      _asyncInputDialog(context, appState, annotationState, annotationBarState);
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyR)) {
      markingDataState.loadFromServer();
    }
    annotationState.additionalSelection = event.isShiftPressed;
    annotationState.borderSelection = event.isAltPressed;
    annotationBarState.setAnnotationMode(annotationState.mode);
    return KeyEventResult.ignored;
  }
}
