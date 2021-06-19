import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klint/state/data/project_state.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';
import 'package:provider/provider.dart';

class DebugItem extends ContextMenuItem {
  final double _height = 40;

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    return Container(
      height: _height,
      color: Color.fromRGBO(r.nextInt(255), r.nextInt(255), r.nextInt(255), 1.0),
      child: Consumer<ProjectState>(
        builder: (context, state, _) => Text(
          state.project?.title ?? "Loading",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  @override
  calculateHeight() => _height;
}
