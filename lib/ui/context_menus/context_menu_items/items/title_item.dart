import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';

class TitleItem extends ContextMenuItem {
  static const double fontSize = 34.0;
  static const double height = 1.0;

  final String text;

  TitleItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: fontSize, height: height));
  }

  @override
  calculateHeight() => fontSize * height;
}
