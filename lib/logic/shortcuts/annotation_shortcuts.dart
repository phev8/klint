import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/ui/context_menus/context_menu.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/debug_item.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  AnnotationShortcuts(BuildContext getContext())
      : super(
          <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.keyT): const _TagIntent(),
            LogicalKeySet(LogicalKeyboardKey.keyD): const _DebugIntent(),
          },
          <Type, Action<Intent>>{
            _TagIntent: CallbackAction<_TagIntent>(onInvoke: (_TagIntent intent) {
              getContext().read<ContextMenuState>().openContextMenu(ContextMenu([
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
              return;
            }),
            _DebugIntent: CallbackAction<_DebugIntent>(onInvoke: (_DebugIntent intent) async {
              return;
            }),
          },
        );
}

class _TagIntent extends Intent {
  const _TagIntent();
}

class _DebugIntent extends Intent {
  const _DebugIntent();
}
