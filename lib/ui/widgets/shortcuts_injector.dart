import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';

class ShortcutsInjector extends StatelessWidget {
  final ShortcutsDefinition shortcutsDefinition;
  final Widget child;

  const ShortcutsInjector({Key? key, required this.child, required this.shortcutsDefinition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: shortcutsDefinition.shortcuts,
      child: Actions(
        actions: shortcutsDefinition.actions,
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}
