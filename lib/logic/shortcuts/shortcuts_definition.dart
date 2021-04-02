import 'package:flutter/material.dart';

abstract class ShortcutsDefinition {
  final Map<LogicalKeySet, Intent> shortcuts;
  final Map<Type, Action<Intent>> actions;

  ShortcutsDefinition(this.shortcuts, this.actions);
}
