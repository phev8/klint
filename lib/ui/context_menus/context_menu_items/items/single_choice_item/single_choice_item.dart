import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/single_choice_item/components/single_choice_widget.dart';
import 'package:tuple/tuple.dart';

import '../section_title_item.dart';

class SingleChoiceItem extends ContextMenuItem {
  final String title;

  late final SectionTitleItem titleItem;
  late final SingleChoiceWidget singleChoiceWidget;

  SingleChoiceItem(
    this.title,
    List<Tuple2<String, String>> options,
    String? initiallySelected,
    Function(String? value) onChanged,
  ) {
    titleItem = SectionTitleItem(title);
    singleChoiceWidget = SingleChoiceWidget(options, initiallySelected, onChanged);
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
