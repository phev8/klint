import 'package:flutter/material.dart';
import 'package:klint/api/entities/enums.dart';
import 'package:klint/api/entities/marking_class.dart';
import 'package:klint/api/entities/tag_marking_option.dart';
import 'package:klint/state/data/marking_data_state.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/ui/context_menus/context_menu.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/multi_choice_item/multi_choice_item.dart';
import 'package:klint/ui/context_menus/context_menu_items/items/section_title_item.dart';
import 'package:tuple/tuple.dart';

import 'context_menu_items/items/single_choice_item/single_choice_item.dart';
import 'context_menu_items/items/spacing_item.dart';
import 'context_menu_items/items/title_item.dart';

class TagContextMenu extends ContextMenu {
  TagContextMenu._(List<ContextMenuItem> items) : super(items);

  factory TagContextMenu(BuildContext context, ProjectState projectState, MarkingDataState markingDataState) {
    List<ContextMenuItem> items;

    if ((projectState.projectKey != "" && projectState.project == null) || markingDataState.markingData == null) {
      items = [SectionTitleItem("Loading")];
    } else if (projectState.project == null || projectState.project!.tagMarkingOptions.length == 0) {
      items = [SectionTitleItem("No Tags")];
    } else {
      var createTagMarkingItem = (TagMarkingOption option) {
        List<Tuple2<String, String>> options = option.classIDs
            .map((classID) => Tuple2<String, String>(
                classID,
                projectState.project!.classes
                    .firstWhere((tagClass) => tagClass.classID == classID,
                        orElse: () => MarkingClass(classID, classID, MarkingScope.TAGS))
                    .defaultTitle))
            .toList();

        if (option.isSingleChoice) {
          List<String> selectedClassIDs = [];
          option.classIDs.forEach((classID) {
            if (markingDataState.markingData!.taggedClassIDs.contains(classID)) selectedClassIDs.add(classID);
          });

          String? initiallySelected = selectedClassIDs.length > 0 ? selectedClassIDs.first : null;

          return SingleChoiceItem(option.title, options, initiallySelected, (value) {
            option.classIDs.forEach((classID) {
              if (value == classID) {
                markingDataState.setTag(classID);
              } else {
                markingDataState.removeTag(classID);
              }
            });
          });
        } else {
          return MultiChoiceItem(
            option.title,
            options,
            markingDataState.markingData!.taggedClassIDs,
            (selected) {
              markingDataState.setTag(selected);
            },
            (deselected) {
              markingDataState.removeTag(deselected);
            },
          );
        }
      };

      items = [
        TitleItem("Tags"),
        SpacingItem(
          factor: 2.0,
        ),
        ...projectState.project!.tagMarkingOptions
            .map(createTagMarkingItem)
            .expand((singleChoiceItem) => [singleChoiceItem, SpacingItem()]),
      ];
    }

    return TagContextMenu._(items);
  }
}
