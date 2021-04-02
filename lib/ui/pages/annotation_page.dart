import 'package:flutter/material.dart';
import 'package:klint/logic/shortcuts/annotation_shortcuts.dart';
import 'package:klint/ui/widgets/shortcuts_injector.dart';

class AnnotationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShortcutsInjector(
      shortcutsDefinition: AnnotationShortcuts(),
      child: Container(),
    );
  }
}
