import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/shortcuts_definition.dart';

class ShortcutsInjector extends StatelessWidget {
  final ShortcutsDefinition shortcutsDefinition;
  final Widget child;

  const ShortcutsInjector({Key? key, required this.child, required this.shortcutsDefinition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKey: (_, event) => shortcutsDefinition.onKey(context, event),
      child: child,
    );
  }
}
