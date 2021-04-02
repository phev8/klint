import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';

class AnnotationShortcuts extends ShortcutsDefinition {
  AnnotationShortcuts()
      : super(
          <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.keyT): const _TagIntent(),
          },
          <Type, Action<Intent>>{
            _TagIntent: CallbackAction<_TagIntent>(onInvoke: (_TagIntent intent) {
              return;
            }),
          },
        );
}

class _TagIntent extends Intent {
  const _TagIntent();
}
