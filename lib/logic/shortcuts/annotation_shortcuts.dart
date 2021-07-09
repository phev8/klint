import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  _toggleAnnotationMode(BuildContext context, AnnotationMode toggleMode) {
    AnnotationState state = context.read<AnnotationState>();
    AnnotationMode currentMode = state.mode;

    state.mode = currentMode == toggleMode ? AnnotationMode.NONE : toggleMode;
    context.read<AnnotationBarState>().setAnnotationMode(state.mode);
  }

  _setAnnotationMode(BuildContext context, AnnotationMode newMode) {
    context.read<AnnotationState>().mode = newMode;
    context.read<AnnotationBarState>().setAnnotationMode(newMode);
  }

  @override
  onKey(context, event) {
    ContextMenuState contextMenuState = context.read<ContextMenuState>();
    if (event.isKeyPressed(LogicalKeyboardKey.keyT)) {
      if (!(contextMenuState.contextMenus.isNotEmpty && contextMenuState.contextMenus.last is TagContextMenu)) {
        contextMenuState.closeContextMenu();
        contextMenuState.openContextMenu(_tagContextMenu);
      } else {
        contextMenuState.closeContextMenu();
      }
      return true;
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
      context.read<MarkingDataState>().saveToServer();
    } else if (event.isKeyPressed(LogicalKeyboardKey.keyB)) {
      if (contextMenuState.contextMenus.isNotEmpty) {
        contextMenuState.closeContextMenu();
        _setAnnotationMode(context, AnnotationMode.BOX);
      } else {
        _toggleAnnotationMode(context, AnnotationMode.BOX);
      }
    }
    return false;
  }
}
