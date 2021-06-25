import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class SpacingItem extends ContextMenuItem {
  final double factor;

  SpacingItem({this.factor = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(height: KlintThemeData.defaultSpacing * factor);
  }

  @override
  calculateHeight() => KlintThemeData.defaultSpacing * factor;
}
