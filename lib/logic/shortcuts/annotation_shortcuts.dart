import 'package:flutter/services.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/ui/context_menus/context_menu.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/debug_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/spacing_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/title_item.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  @override
  onKey(context, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.keyT)) {
      context.read<ContextMenuState>().openContextMenu(ContextMenu([
            TitleItem("Debug Title"),
            SpacingItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
            DebugItem(),
          ]));
      return true;
    }
    return false;
  }
}
