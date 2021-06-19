import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';

class SectionTitleItem extends ContextMenuItem {
  static const double fontSize = 16.0;
  static const double height = 1.0;

  final String text;

  SectionTitleItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, height: height));
  }

  @override
  calculateHeight() => fontSize * height;
}
