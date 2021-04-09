import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:provider/provider.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  AnnotationShortcuts(BuildContext getContext())
      : super(
          <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.keyT): const _TagIntent(),
          },
          <Type, Action<Intent>>{
            _TagIntent: CallbackAction<_TagIntent>(onInvoke: (_TagIntent intent) {
              Provider.of<ContextMenuState>(getContext(), listen: false).openDebugMenu(getContext());
              return;
            }),
          },
        );
}

class _TagIntent extends Intent {
  const _TagIntent();
}
