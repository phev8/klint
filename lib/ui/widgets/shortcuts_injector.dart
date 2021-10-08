import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';

class ShortcutsInjector extends StatelessWidget {
  final ShortcutsDefinition shortcutsDefinition;
  final Widget child;
  final FocusScopeNode fNode = FocusScopeNode(debugLabel: "Own FocusScopeNode");

  ShortcutsInjector({Key? key, required this.child, required this.shortcutsDefinition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusScope(
        debugLabel: "Own FocusScope",
        node: fNode,
        child: Focus(
          autofocus: true,
          debugLabel: "Own Focus",
          onFocusChange: (bool focused) {
            //debugDumpFocusTree();
            if (FocusScope.of(context).focusedChild == null) {
              FocusScope.of(context).autofocus(fNode);
            }
          },
          onKey: (_, event) => shortcutsDefinition.onKey(context, event),
          child: child,
        ));
  }
}
