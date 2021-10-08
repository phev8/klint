import 'package:flutter/material.dart';

abstract class ShortcutsDefinition {
  KeyEventResult onKey(BuildContext context, RawKeyEvent event);
}
