import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';

class SpacingItem extends ContextMenuItem {
  static const double spacing = 8.0;
  final double factor;

  SpacingItem({this.factor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(height: spacing * factor);
  }

  @override
  calculateHeight() => spacing * factor;
}
