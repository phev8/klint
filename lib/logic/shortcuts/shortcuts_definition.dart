import 'package:flutter/material.dart';

abstract class ShortcutsDefinition {
  bool onKey(BuildContext context, RawKeyEvent event);
}
