import 'package:flutter/material.dart';

abstract class ShortcutsDefinition {
  onKey(BuildContext context, RawKeyEvent event);
}
