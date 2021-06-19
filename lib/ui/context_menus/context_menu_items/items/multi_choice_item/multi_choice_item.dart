import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/multi_choice_item/components/multi_choice_widget.dart';
import 'package:tuple/tuple.dart';

import '../section_title_item.dart';

class MultiChoiceItem extends ContextMenuItem {
  final String title;

  late final SectionTitleItem titleItem;
  late final MultiChoiceWidget singleChoiceWidget;

  MultiChoiceItem(
    this.title,
    List<Tuple2<String, String>> options,
    List<String> initiallySelected,
    Function(String value) onSelected,
    Function(String value) onDeselected,
  ) {
    titleItem = SectionTitleItem(title);
    singleChoiceWidget = MultiChoiceWidget(options, initiallySelected, onSelected, onDeselected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        titleItem,
        singleChoiceWidget,
      ],
    );
  }

  @override
  calculateHeight() => titleItem.calculateHeight() + singleChoiceWidget.calculateHeight();
}
