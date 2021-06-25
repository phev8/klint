import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

class SectionTitleItem extends ContextMenuItem {
  final String text;

  SectionTitleItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: KlintThemeData.menuSectionTextStyle);
  }

  @override
  calculateHeight() => KlintThemeData.menuSectionTextStyle.fontSize! * KlintThemeData.menuSectionTextStyle.height!;
}
