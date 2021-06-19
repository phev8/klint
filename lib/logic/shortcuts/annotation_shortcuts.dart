import 'package:flutter/services.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/ui/context_menus/tag_context_menu.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  TagContextMenu _tagContextMenu;

  AnnotationShortcuts(this._tagContextMenu);

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
    }
    return false;
  }
}
